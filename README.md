![.github/workflows/test.yml](https://github.com/JJ/raku-syslog-parse/workflows/.github/workflows/test.yml/badge.svg)

NAME
====

Syslog::Parse - Creates a supply out of syslog entries

SYNOPSIS
========

```perl6
use Syslog::Parse;

my $parser = Syslog::Parse.new;

$parser.parsed.tap: -> $v {
    say $v;
}

sleep( @*ARGS[0] // 120 );
```

Or

```raku
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
```

Also, you can run

```shell
watch-syslog.p6
```

which is going ot be installed along with the distribution.

DESCRIPTION
===========

Syslog::Parse is a parser that extracts information from every line in 
`/var/log/syslog`. Creates two objects of the kind `Supply`: one (simply 
called `.supply`) that returns the raw lines, another, `.parsed`, which 
returns a structure with the following keys:

```text
day # Day in the month
month # TLA of month
hour # String with hour
hostname # Hostname that produced it
actor # Who produced the message log
pid # Sometimes, it goes with a PID
message # Another data structure, with key message (the whole message) and
        # user if one has been identified
```

## PLATFORMS

It works on platforms that use `/var/log/syslog` as a syslog file,
with the same format. All Debian seem to be that way.

If you don't have that platform, you can still use the grammars on
files with that format.

AUTHOR
======

JJ Merelo <jjmerelo@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

