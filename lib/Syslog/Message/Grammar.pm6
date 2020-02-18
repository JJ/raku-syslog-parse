use Syslog::Who::Grammar;

unit role Syslog::Message::Grammar does Syslog::Who::Grammar;

token user { "(" <who> [":" \d+ ]? ")" }
