#!/usr/bin/env raku

use lib 'lib';

use Syslog::Parse;

my $parser = Syslog::Parse.new;

$parser.parsed.tap: -> $v {
    say $v;
}

sleep( @*ARGS[0] // 120 );
