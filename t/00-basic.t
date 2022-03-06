use Test;
use Test::Output;

use CoreHackers::Q;

stdout-like( { q-run( ["raku", "-Ilib", "t/00-basic.t"]) },
        /"Rakudo version"/, "Output created");
done-testing;
