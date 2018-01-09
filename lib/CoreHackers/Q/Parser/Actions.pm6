unit class CoreHackers::Q::Parser::Actions;
use HTML::Escape;

sub prefix:<E> { $^t.Str.&escape-html }

method TOP($/) {
    make Q:to/♥/ ~ $<line>».made.join("\n")
      <!DOCTYPE html>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Perl 6 QAST Viewer</title>
      <link rel="stylesheet" href="main.css">
      ♥
}

method line($/) {
    make ｢<p class='line'>｣ ~ ｢<span class='level'></span>｣ x $<level>.made
      ~ ($<data> ?? $<data>.made !! E$<unknown>)
}

method data:sym<qast>($/) {
    make ｢<span class="qast ｣ ~ qast-marker-for(~$<rest>) ~ ｢"><b>｣
      ~ E$<name> ~ ｢</b> ｣ ~ E$<rest>.trim ~ ｢</span>｣
}

method level($/) {
    make $/.chars/2
}

sub qast-marker-for (Str:D $_) {
    join '', map 'qast-'~*, gather {
        /«sunk»/ and take 'sunk';
    }
}
