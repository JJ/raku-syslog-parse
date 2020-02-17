use v6.c;
use Test;
use Syslog::Grammar;

say Syslog::Grammar.parse( "Feb 17 19:40:01 penny CRON[20759]: (root) CMD (   test -x /etc/cron.daily/popularity-contest && /etc/cron.daily/popularity-contest --crond)" );

done-testing;
