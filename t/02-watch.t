use Test; # -*- mode: perl6 -*-

use Syslog::Parse;

if "/var/log/syslog".IO.e {
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
} else {
    skip "File /var/log/syslog was not detected";
}

done-testing;
