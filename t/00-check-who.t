use Test;

use Syslog::Who::Grammar;

my @names = <root CRON postfix/cleanup gnome-session org.gtk.vfs.Daemon>;

grammar Gratest does Syslog::Who::Grammar {
    token TOP { <who> };
}

for @names -> $n {
    is Gratest.parse( $n )<who>, $n, "$n Name checks out";
}
done-testing;
