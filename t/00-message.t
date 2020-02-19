use Test;

use Syslog::Message::Grammar;
use Syslog::Message::Action;

grammar Gratest does Syslog::Message::Grammar {
    token TOP { <message> };
}

class GratestAction does Syslog::Message::Action {
    method TOP($/) {
        make $<message>.made
    }
}

my @names = <root systemd-tmpfiles gnome-shell-calendar-server:5539>;

for @names -> $n {
    ok Gratest.parse( "($n) Stuff" )<message>, "$n checks";
}

my $message = "(98)Address already in use: AH00072: make_sock: could not bind to address [::]:80";

like Gratest.parse( $message )<message>, /"sock"/, "Message 1";

$message = "(CRON) INFO (Running @reboot jobs)";

is Gratest.parse( $message )<message><user><who>, "CRON",
        "Message with someone";

my %parsed-message =
        Gratest.parse( $message, actions => GratestAction.new).made;

is %parsed-message<user>, "CRON", "Actions tested";

$message = " Supervising 7 threads of 5 processes of 1 users.";

ok Gratest.parse($message)<message>, "Parsing message";

%parsed-message = Gratest.parse( $message,
        actions => GratestAction.new).made;

like %parsed-message<message>, /^^" Supervising"/, "Non-user message";

ok Gratest.parse("")<message>, "Parsing empty message";

done-testing;
