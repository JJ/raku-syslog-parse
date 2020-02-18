use Test;

use Syslog::Who::Grammar;
use Syslog::Who::Action;

my @names = <root CRON postfix/cleanup gnome-session org.gtk.vfs.Daemon>;

grammar Gratest does Syslog::Who::Grammar {
    token TOP { <who> };
}

class GratestAction does Syslog::Who::Action {
    method TOP($/) { make $<who> }
}

for @names -> $n {
    is Gratest.parse( $n )<who>, $n, "$n Name checks out";
    is Gratest.parse( $n, actions => GratestAction.new ).made,
            $n, "Action works";
}
done-testing;
