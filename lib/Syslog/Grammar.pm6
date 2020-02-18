# use Grammar::Tracer;
use Syslog::Who::Grammar;
use Syslog::Message::Grammar;

unit grammar Syslog::Grammar
        does Syslog::Who::Grammar
        does Syslog::Message::Grammar;

token TOP {
    <month> \s+ <day> \s+ <hour> \s+ <hostname> \s+
    <actor> ":" \s+ <message>
}

token month { [ "Jan"| "Feb" | "Mar" | "Apr" | "May" | "Jun"
 "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec" ]}
token day { \d+ }
token hour { [\d+] ** 3 % ":" }
token hostname { \S+ }
token actor { [ <who> "[" <pid> "]" | <who> ] }
token pid { \d+ }
