use Test;

use Syslog::Message::Grammar;

grammar Gratest does Syslog::Message::Grammar {
    token TOP { <message> };
}

my @names = <root systemd-tmpfiles gnome-shell-calendar-server:5539>;

for @names -> $n {
    ok Gratest.parse( "($n) Stuff" )<message>, "$n checks";
}

done-testing;
