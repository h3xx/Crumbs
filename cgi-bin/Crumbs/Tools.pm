package Crumbs::Tools;
use strict;
use warnings;

our $VERSION = '0.01';

sub vfy_url {
	my ($cgi, $un, $vfy) = @_;

	sprintf '%s://%s/u?a=verify?u=%s;v=%s',
		$cgi ? ($cgi->https ? 'https' : 'http') : 'poop',
		$ENV{'HTTP_HOST'},
		$cgi->url_encode($un),
		$cgi->url_encode($vfy);

}

sub rst_url {
	my ($cgi, $un, $rst) = @_;

	sprintf '%s://%s/pwreset?u=%s;r=%s',
		$cgi ? ($cgi->https ? 'https' : 'http') : 'poop',
		$ENV{'HTTP_HOST'},
		$cgi->url_encode($un),
		$cgi->url_encode($rst);
	
}

sub is_valid_email {
	my $em = shift;

	# email regex care of: http://www.regular-expressions.info/email.html
	# modified to be PCRE
	$em =~ m/^[\w._%+-]+@[\w.-]+\.[a-z]{2,4}$/i
}

sub mail {
	my ($to, $from, $subj, $body, $headers) = @_;

	use Mail::Sendmail	qw/ sendmail /;

	my %mail = (
		'To'		=> $to,
		'From'		=> $from,
		'Message'	=> $body,
		'Content-Type'	=> 'text/html; charset=utf8',
		(defined $headers ? %{$headers} : ()),
	);

	&sendmail(%mail)
}

sub is_numeric {
	foreach my $n (@_) {
		return 0 unless defined $n and $n =~ /\d[\d.]*/;
	}
	1;
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
