import python
import semmle.python.regexp.RegexTreeView::RegexTreeView as TreeView

from TreeView::RegExpLiteral t
// where t.getRegex().getLocation().getFile().getRelativePath().regexpMatch(".*ChuanhuChatGPT.*")
select t.getRegex().getText(), t.getRegex().getLocation().getFile().getRelativePath(), t.getRegex().getLocation()