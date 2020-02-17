unit grammar Syslog::Grammar;

token TOP { <day> \s+ <hour> }

token month { [ "Jan"| "Feb" | "Mar" | "Apr" | "May" | "Jun"
 "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec" ]}
token day { \d+ }
token hour { [\d+] ** 3 % ":" }
