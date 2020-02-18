# use Grammar::Tracer;

unit grammar Syslog::Grammar;

token TOP {
    <month> \s+ <day> \s+ <hour> \s+ <hostname> \s+
    [ <who> "[" <pid> "]" | "kernel" ]
    ":" \s+ <message>
}

token month { [ "Jan"| "Feb" | "Mar" | "Apr" | "May" | "Jun"
 "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec" ]}
token day { \d+ }
token hour { [\d+] ** 3 % ":" }
token hostname { \S+ }
token who { <[\w] + [.-]>+ }
token pid { \d+ }
token message { .+ }
