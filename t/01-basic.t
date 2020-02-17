use v6.c;
use Test;
use Syslog::Grammar;

say Syslog::Grammar.parse( "Feb 17 19:48:13 penny firefox.desktop[" );

done-testing;
