use Test;

use Syslog::Message::Grammar;

grammar Gratest does Syslog::Message::Grammar {
    token TOP { <user> };
}
say Gratest.parse( "(root)" );

done-testing;
