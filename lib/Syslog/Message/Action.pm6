use Syslog::Who::Action;

unit role Syslog::Message::Action does Syslog::Who::Action;

method message ($/) {
    if $<user> {
        return $<message>.made but $<user>.made
    } else {
        return $<message>.made
    }
}
method user ($/) { make $<who>.made }
