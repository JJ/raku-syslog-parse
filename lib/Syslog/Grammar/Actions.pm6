unit class Syslog::Grammar::Actions;

method pid($/)     { make +$/ }
method hour($/)    { make +$/ }
method day($/)     { make +$/ }
method month($/)   { make ~$/ }
method hostname($/) { make ~$/ }
