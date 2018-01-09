unit grammar CoreHackers::Q::Parser;
use CoreHackers::Q::Parser::Actions;

method view (Str:D $source) {
    self.parse($source, :actions(CoreHackers::Q::Parser::Actions)).made;
}

token TOP      { :my $*indent = 0; <node>+ }
token node     { <node-text> [\n {$*indent++} <children> {$*indent--}]? }
token children { ['  '**{$*indent} <node>]* }

proto token node-text {*}
token node-text:sym<qast> { '- QAST::' $<name>=\S+ $<rest>=\N+ }
token node-text:sym<misc> { \N+ }




# token line {
#     <level> [<data>||<unknown>] \n
# }
#
# token level {
#     '  '*
# }
#
# proto token data {*}
# token data:sym<qast> {
#     '- QAST::' <name=ident> $<rest>=\N+
# }
# token unknown {
#     \N+
# }
