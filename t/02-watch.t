use Test;
use Syslog::Parse;

my $parser = Syslog::Parse.new;

isa-ok $parser.supply, Supply, "Created supply";

done-testing;
