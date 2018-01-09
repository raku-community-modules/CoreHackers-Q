unit class CoreHackers::Q::Parser::Actions;
use HTML::Escape;

sub prefix:<E> { $^t.Str.&escape-html }

method TOP($/) {
    make Q:to/♥/ ~ ｢<ul class="nodes">｣ ~ $<node>».made.join("\n") ~ ｢</ul>｣;
      <!DOCTYPE html>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Perl 6 QAST Viewer</title>
      <link rel="stylesheet" href="main.css">
      <script
          src="https://code.jquery.com/jquery-3.2.1.min.js"
          integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
          crossorigin="anonymous"></script>
      <script src="main.js"></script>
      ♥
}

method node($/) {
    make ｢<li class="node｣
        ~ ｢ node-with-kids｣ x ?$<children>.made
        ~ ｢">｣ ~ $<node-text>.made ~ $<children>.made ~ ｢</li>｣
}

method node-text:sym<qast>($/) {
    make ｢<b class="qast">｣ ~ E$<name> ~ ｢</b>｣ ~ E$<rest>
}
method node-text:sym<misc>($/) { make E$/.trim }

method children($/) {
    make $<node>.elems ?? ｢<ul class="nodes">｣ ~ $<node>».made ~ ｢</ul>｣ !! ''
    # exit if $++ > 2;
    # make $/.list.head.map: *<node>.made
}

#
# method line($/) {
#     make ｢<p class='line'>｣ ~ ｢<span class='level'></span>｣ x $<level>.made
#       ~ ($<data> ?? $<data>.made !! E$<unknown>)
# }
#
# method data:sym<qast>($/) {
#     make ｢<span class="qast ｣ ~ qast-marker-for(~$<rest>) ~ ｢"><b>｣
#       ~ E$<name> ~ ｢</b> ｣ ~ E$<rest>.trim ~ ｢</span>｣
# }
#
# method level($/) {
#     make $/.chars/2
# }
#
# sub qast-marker-for (Str:D $_) {
#     join '', map 'qast-'~*, gather {
#         /«sunk»/ and take 'sunk';
#     }
# }
