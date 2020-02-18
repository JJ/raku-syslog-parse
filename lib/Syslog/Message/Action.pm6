use Syslog::Who::Action;

unit role Syslog::Message::Action does Syslog::Who::Action;

method message ($/) {
    my %response = %();
    %response<message> = ( $<message> // "∅" ).Str;
    %response<user> = ( $<user><who> // "∅" ).Str;
    make %response;
}

