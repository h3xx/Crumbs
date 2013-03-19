#!C:\xampp\perl\bin\perl.exe
# #!/usr/bin/perl
use strict;

use CGI;

my $cgi = CGI->new;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/plain',
		'-charset'	=> 'utf8',
	);
}

print "Hello world\n";
