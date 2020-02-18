use Syslog::Who::Grammar;

unit role Syslog::Message::Grammar does Syslog::Who::Grammar;

token message { <user>? .+ }
token user { "(" <who> [":" \d+ ]? ")" }
