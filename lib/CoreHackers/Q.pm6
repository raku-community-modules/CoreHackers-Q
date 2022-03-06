use CoreHackers::Q::Parser;

sub q-run (@args, :$opt) is export {
    @args.splice: 1, 0, ['--target=' ~ ($opt ?? 'optimize' !! 'ast')];
    my $source = (run @args, :out).out.slurp: :close;
    say CoreHackers::Q::Parser.new.view: ~@args.map({
        /\s/ ?? "'$_'" !! $_
    }), $source;
}

sub zero-run(@args) is export { q-run: @args }
