use Test;

use Syslog::Message::Grammar;

grammar Gratest does Syslog::Message::Grammar {
    token TOP { <user> };
}

my @names = <root systemd-tmpfiles gnome-shell-calendar-server:5539>;

for @names -> $n {
    ok Gratest.parse( "($n)" )<user>, "$n checks";
}

done-testing;
