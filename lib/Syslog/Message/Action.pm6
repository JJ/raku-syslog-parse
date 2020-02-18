use Syslog::Who::Action;

unit role Syslog::Message::Action does Syslog::Who::Action;

method message ($/) {
    make {
        message => ~$<message>,
        user => ~$<user><who> // "∅";
    }
}

