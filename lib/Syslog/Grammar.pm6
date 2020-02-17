use Grammar::Tracer;

unit grammar Syslog::Grammar;

token TOP { <month> \s+ <day> \s+ <hour> \s+ <hostname> \s+ <appname> "["}

token month { [ "Jan"| "Feb" | "Mar" | "Apr" | "May" | "Jun"
 "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec" ]}
token day { \d+ }
token hour { [\d+] ** 3 % ":" }
token hostname { \S+ }
token appname { <[\w] + ["."]>+ }
token pid { \d+ }
