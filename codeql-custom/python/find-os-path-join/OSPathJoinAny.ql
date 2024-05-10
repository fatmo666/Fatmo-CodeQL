/**
 * @name Tainted Data Flow to os.path.join
 * @kind path-problem
 * @problem.severity warning
 * @id python/example/tainted-os-path-join
 * @description Identifies flows of tainted data from external sources into any argument of `os.path.join`.
 * This can lead to potential security vulnerabilities if the resulting path is used to access the file system.
 */

import python
import semmle.python.ApiGraphs
import semmle.python.dataflow.new.DataFlow
import semmle.python.dataflow.new.TaintTracking
import semmle.python.dataflow.new.RemoteFlowSources
import MyFlow::PathGraph

class OsPathJoinCall extends DataFlow::CallCfgNode {
    OsPathJoinCall() {
        this = API::moduleImport("os").getMember("path").getMember("join").getACall()
    }
}

private module MyConfig implements DataFlow::ConfigSig {
    predicate isSource(DataFlow::Node source) {
        // source instanceof RemoteFlowSource
        any()
    }

    predicate isSink(DataFlow::Node sink) {
        exists(OsPathJoinCall joinCall | 
            sink = joinCall.getArg(_))
    }
}

module MyFlow = TaintTracking::Global<MyConfig>; 

from MyFlow::PathNode source, MyFlow::PathNode sink
where MyFlow::flowPath(source, sink)
select sink.getNode(), source, sink, "os.path.join in untrusted data"