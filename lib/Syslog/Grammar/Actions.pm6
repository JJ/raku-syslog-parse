use Syslog::Who::Action;
use Syslog::Message::Action;

unit class Syslog::Grammar::Actions
    does Syslog::Who::Action does Syslog::Message::Action;

method TOP($/) {
    my %entry = $<message>.made;
    for <pid hour day month hostname who> -> $key {
        %entry{$key} = $/{$key}.made
    }
    make %entry;
}

method pid($/)     { make +$/ }
method hour($/)    { make ~$/ }
method day($/)     { make +$/ }
method month($/)   { make ~$/ }
method hostname($/) { make ~$/ }
