use Syslog::Who::Grammar;

unit role Syslog::Message::Grammar does Syslog::Who::Grammar;

token message { \s* <user>? .+ }
token user { "(" <who> [":" \d+ ]? ")" }
