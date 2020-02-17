use v6.c;
use Test;
use Syslog::Grammar;

my $match = Syslog::Grammar.parse: "Feb 17 19:40:01 penny CRON[20759]: (root)
CMD
(   test -x /etc/cron.daily/popularity-contest && /etc/cron.daily/popularity-contest --crond)" ;

is $match<appname>, "CRON", "Appname caught";
like $match<message>, /daily/, "Message caught";

done-testing;
