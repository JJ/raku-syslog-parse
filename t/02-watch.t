use Test;
use Syslog::Parse;

my $parser = Syslog::Parse.new;

isa-ok $parser.supply, Supply, "Created supply";
isa-ok $parser.parsed, Supply, "Created supply of parsed lines";

Promise.at(now+1).then: {
    shell "logger logging $_" for ^10;
};

react {
    whenever $parser.parsed -> %v {
        like %v<message>, /logging/, "Parses logs";
        done();
    }
}

done-testing;
