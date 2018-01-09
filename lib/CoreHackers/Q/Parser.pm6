unit grammar CoreHackers::Q::Parser;
use CoreHackers::Q::Parser::Actions;

method view (Str:D $source) {
    self.parse($source, :actions(CoreHackers::Q::Parser::Actions)).made;
}

token TOP {
    <line>+
}

token line {
    <level> [<data>||<unknown>] \n
}

token level {
    '  '*
}

proto token data {*}
token data:sym<qast> {
    '- QAST::' <name=ident> $<rest>=\N+
}
token unknown {
    \N+
}
