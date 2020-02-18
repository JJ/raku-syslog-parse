use Test;
use Syslog::Parse;

my $parser = Syslog::Parse.new;

isa-ok $parser.supply, Supply, "Created supply";
isa-ok $parser.parsed, Supply, "Created supply of parsed lines";

$parser.parsed.tap: -> $v {
    say $v;
}

done-testing;
