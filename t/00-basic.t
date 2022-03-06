use Test;

use CoreHackers::Q;

q-run( ["raku", "-Ilib", "t/00-basic.t"]);

like( "out.html".IO.slurp, /"Rakudo version"/, "Output created");
done-testing;
