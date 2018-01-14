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
      <!-- CSS INSERT START -->
      <link rel="stylesheet" href="/home/zoffix/q/main.css">
      <!-- CSS INSERT END -->
      <script
          src="https://code.jquery.com/jquery-3.2.1.min.js"
          integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
          crossorigin="anonymous"></script>
      <!-- JS INSERT START -->
      <script src="/home/zoffix/q/main.js"></script>
      <!-- JS INSERT END -->

      <div id="info-panel">
        <p><kbd>Ctrl+Click</kbd> to collapse/uncollapse nodes</p>
      </diV>
      ♥
}

method node($/) {
    my ($text, @classes) = $<node-text>.made;
    make ｢<li class="node ｣
        ~ (@classes.map: 'qast-' ~ *)
        ~ ｢ node-with-kids｣ x ?$<children>.made
        ~ ｢ qast-want-v｣    x ?$*qast-want-v
        ~ ｢">｣ ~ $text ~ $<children>.made ~ ｢</li>｣
}

method node-text:sym<qast>($/) {
    make (
        ｢<b class="qast">｣ ~ E$<name> ~ ｢ </b>｣ ~ E$<rest>,
        |gather {
            take 'sunk' if $/.contains: 'sunk';
            take 'name-' ~ lc $<name>;
            if $/.contains: 'chainstatic' | 'callstatic' {
                take 'static-call'
            }
            elsif $/.contains: 'chain' | 'call' {
                take 'call'
            }
        }
    )
}
method node-text:sym<misc>($/)   { make E$/.trim }
method node-text:sym<want-v>($/) { make E$/ }

method children($/) {
    make $<node>.elems ?? ｢<ul class="nodes">｣ ~ $<node>».made ~ ｢</ul>｣ !! ''
}
