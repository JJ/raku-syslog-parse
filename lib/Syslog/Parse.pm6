use v6.c;

use Syslog::Grammar;
use Syslog::Grammar::Actions;

unit class Syslog::Parse:ver<0.0.2>:auth<cpan:JMERELO>;

has $.path;
has Supply $.supply;
has Supply $.parsed;

submethod BUILD ( :$!path = "/var/log/syslog") {
    $!supply = IO::Notification.watch-path( $!path );
    $!parsed = supply {
        my @all-lines;
        whenever $!supply -> $v {
            if $v.event == FileChanged {
                my @these-lines = $!path.IO.slurp.lines;
                if @these-lines.elems > @all-lines.elems {
                    @all-lines = @these-lines;
                    for (@these-lines.elems - @all-lines.elems) … 0 {
                        my $line = @these-lines.pop;
                        emit Syslog::Grammar.parse(
                                $line,
                                actions => Syslog::Grammar::Actions.new
                                ).made;

                        CATCH {
                            default {
                                $*ERR.say: .message;
                            }
                        }
                    }
                }
            }

        }
    }
}


=begin pod

=head1 NAME

raku::syslog::parse - Creates a supply out of syslog entries

=head1 SYNOPSIS

=begin code :lang<perl6>

use Syslog::Parse;

my $parser = Syslog::Parse.new;

$parser.parsed.tap: -> $v {
    say $v;
}

sleep( @*ARGS[0] // 120 );

=end code

Or

=begin code
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
=end code

=head1 DESCRIPTION

Syslog::Parse is a parser that extracts information from every line in
C</var/log/syslog>. Creates two objects of the kind C<Supply>: one (simply
called C<.supply> that returns the raw lines, another, C<.parsed>, which
returns a structure with the following keys:

=for code :lang<text>
day # Day in the month
month # TLA of month
hour # String with hour
hostname # Hostname that produced it
actor # Who produced the message log
pid # Sometimes, it goes with a PID
message # Another data structure, with key message (the whole message) and
        # user if one has been dentified


=head1 AUTHOR

JJ Merelo <jjmerelo@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
