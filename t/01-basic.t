use v6.c;
use Test;
use Syslog::Grammar;

say Syslog::Grammar.parse( "19:48:13" );

done-testing;
