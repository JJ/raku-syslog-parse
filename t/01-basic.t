use v6.c;
use Test;
use Syslog::Grammar;

my $match = Syslog::Grammar.parse:
        "Feb 17 19:40:01 penny CRON[20759]: (root) CMD (   test -x /etc/cron.daily/popularity-contest && /etc/cron.daily/popularity-contest --crond)" ;

is $match<who>, "CRON", "Who";
like $match<message>, /daily/, "Message";

$match = Syslog::Grammar.parse: "Feb 18 07:21:11 penny kernel: [  848.864490] ata1.00: cmd 61/08:f0:40:02:51/00:00:07:00:00/40 tag 30 ncq dma 4096 out";

like $match<message>, /ncq/, "kernel message";

$match = Syslog::Grammar.parse: 'Feb 18 07:22:10 penny systemd-tmpfiles[11979]: [/usr/lib/tmpfiles.d/var.conf:14] Duplicate line for path "/var/log", ignoring.';

like $match<who>, /"systemd-tmpfiles"/, "appname with dash";

done-testing;
