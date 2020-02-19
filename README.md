[![Build Status](https://travis-ci.org/JJ/raku-syslog-parse.svg?branch=master)](https://travis-ci.org/JJ/raku-syslog-parse)

NAME
====

raku::syslog::parse - Creates a supply out of syslog entries

SYNOPSIS
========

```perl6
use Syslog::Parse;

use Syslog::Parse;

my $parser = Syslog::Parse.new;

$parser.parsed.tap: -> $v {
    say $v;
}

sleep( @*ARGS[0] // 120 );
```

Or

    use Syslog::Parse;
    my $parser = Syslog::Parse.new;
    Promise.at(now+1).then: {
        shell "logger logging $_" for ^10;
    };

    react {
        whenever $parser.parsed -> %v {
            say %v;
            done(); # Just interested in the last one
        }
    }

DESCRIPTION
===========

Syslog::Parse is a parser that extracts information from every line in `/var/log/syslog`. Creates two objects of the kind `Supply`: one (simply called `.supply` that returns the raw lines, another, `.parsed`, which returns a structure with the following keys:

```text
day # Day in the month
month # TLA of month
hour # String with hour
hostname # Hostname that produced it
actor # Who produced the message log
pid # Sometimes, it goes with a PID
message # Another data structure, with key message (the whole message) and
        # user if one has been dentified
```

AUTHOR
======

JJ Merelo <jjmerelo@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

