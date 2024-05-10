import python
import semmle.python.dataflow.new.RemoteFlowSources

from RemoteFlowSource::Range source
select source, source.getLocation(), "A remote flow source"