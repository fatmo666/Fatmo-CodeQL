import python
import semmle.python.ApiGraphs

from API::Node node
where node = API::moduleImport("os").getMember("path").getMember("join")
select node.getLocation()
