use Syslog::Who::Action;
use Syslog::Message::Action;

unit class Syslog::Grammar::Actions
    does Syslog::Who::Action does Syslog::Message::Action;

method TOP($/) {
    my %entry = $<message>.made;
    for <pid hour day month hostname who actor> -> $key {
        %entry{$key} = $/{$key}.made
    }
    make %entry;
}

method pid($/)     { make +$/ }
method hour($/)    { make ~$/ }
method day($/)     { make +$/ }
method month($/)   { make ~$/ }
method actor($/)   { make ~$/<who> }
method hostname($/) { make ~$/ }
