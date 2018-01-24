unit class CoreHackers::Q::Parser::Actions;
use HTML::Escape;

has Str:D $.code is required;

sub prefix:<E> { $^t.Str.&escape-html }

method TOP($/) {
    make q:to/♥/ ~ ｢<ul class="nodes">｣ ~ $<node>».made.join("\n") ~ ｢</ul>｣;
      <!DOCTYPE html>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Perl 6 QAST Viewer</title>
      <!-- CSS INSERT START --><style>
      * {
          margin: 0;
          padding: 0;
      }

      html {
          background: #ddddd2;
          color: #333;
      }

      body {
          width: 1200px;
          margin: 20px auto;
      }

      #info-panel {
          padding: 20px;
          border: 1px solid #999;
          margin-bottom: 10px;
          background: #ddc;
      }

      h1 code {
          display: block;
          color: #707;
          font-size: 16px;
          font-weight: normal;
          margin-bottom: 10px;
          border-bottom: 1px solid #999;
          padding-bottom: 10px;
      }

      li {
          list-style: none;
      }
      li li {
          padding-left: 2em;
          border-left: 1px dotted #333;
      }

      .node-with-kids:before {
          content: "[-]";
          font-size: 80%;
          font-family: monospace;
          color: #66c;
      }
      .node-with-kids.collapsed:before {
          content: "[+]";
      }

      .qast-sunk {
          background: rgba(150, 150, 200, .1);
      }
      .qast-sunk .qast-sunk .qast-sunk .qast-sunk .qast-sunk {
          background: none;
      }

      .qast-name-vm {
          opacity: .5;
      }
      .qast-name-var {
          color: #d0d;
      }
      .qast-name-wval {
          color: #00a;
      }
      .qast-static-call {
          color: green;
      }
      .qast-call {
          color: red;
      }
      .qast-want-v {
          color: #999;
          opacity: .5;
      }

      </style><!-- CSS INSERT END -->
      <script
          src="https://code.jquery.com/jquery-3.2.1.min.js"
          integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
          crossorigin="anonymous"></script>
      <!-- JS INSERT START --><script>
      jQuery(function ($) {
          setup_nodes();
      });

      function setup_nodes() {
          $('body').css({'height': document.body.scrollHeight + 'px'});

          $('.node-with-kids').on('click', function(e) {
              if (e.ctrlKey) {
                  e.stopPropagation();
                  $(this).find('> ul').toggle('fast', function() {
                      $(this).parent('.node-with-kids').toggleClass('collapsed');
                  });
              }
          });
      }

      </script><!-- JS INSERT END -->

      <div id="info-panel">
        <p><i><kbd>Ctrl+Click</kbd> to collapse/uncollapse nodes</i></p>
      </diV>
      <h1><code>\qq[$!code]</code></h1>
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
