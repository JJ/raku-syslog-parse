use v6.c;

use Syslog::Grammar;
use Syslog::Grammar::Actions;

unit class Syslog::Parse:ver<0.0.1>:auth<cpan:JMERELO>;

has $.path;
has Supply $.supply;
has Supply $.parsed;

submethod BUILD ( :$!path = "/var/log/syslog") {
    $!supply = IO::Notification.watch-path( $!path );
    $!parsed = supply {
        $!supply.tap: -> $v {
            state @all-lines;
            if $v.event == FileChanged {
                my @these-lines = $!path.IO.slurp.lines;
                if @these-lines.elems > @all-lines.elems {
                    for (@these-lines.elems - @all-lines.elems) … 1 -> $i {
                        say @these-lines[*-$i];
                        say Syslog::Grammar.parse(
                                @these-lines[*-$i],
                                actions => Syslog::Grammar::Actions.new
                                ).made;
#                        emit Syslog::Grammar.parse(
#                                @these-lines[*-$i],
#                                actions => Syslog::Grammar::Actions.new
#                                ).made;
                        emit(33);
                        CATCH {
                            default {
                                $*ERR.say: .message;
                            }
                        }
                    }
                    @all-lines = @these-lines;
                }
            }

        }
    }
}


=begin pod

=head1 NAME

raku::syslog::parse - blah blah blah

=head1 SYNOPSIS

=begin code :lang<perl6>

use Syslog::Parse;

=end code

=head1 DESCRIPTION

Syslog::Parse is ...

=head1 AUTHOR

JJ Merelo <jjmerelo@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
