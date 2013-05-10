package Crumbs::Tools;
use strict;
use warnings;

our $VERSION = '0.01';

sub vfy_url {
	my ($cgi, $un, $vfy) = @_;

	sprintf '%s://%s/u?a=verify;u=%s;v=%s',
		$cgi ? ($cgi->https ? 'https' : 'http') : 'poop',
		($ENV{'HTTP_HOST'} || 'localhost'),
		$cgi->url_encode($un),
		$cgi->url_encode($vfy);

}

sub rst_url {
	my ($cgi, $un, $rst) = @_;

	sprintf '%s://%s/pwreset?u=%s;r=%s',
		$cgi ? ($cgi->https ? 'https' : 'http') : 'poop',
		($ENV{'HTTP_HOST'} || 'localhost'),
		$cgi->url_encode($un),
		$cgi->url_encode($rst);
	
}

=head2 is_valid_email($email)

Checks whether an email address is in a valid format. Only handles NAME@DOMAIN
style email addresses, and not `First Last <NAME@DOMAIN>' style.

=cut

sub is_valid_email {
	my $em = shift;

	# email regex care of: http://www.regular-expressions.info/email.html
	# modified to be PCRE
	$em =~ m/^[\w._%+-]+@[\w.-]+\.[a-z]{2,4}$/i
}

=head2 mail($to, $from, $subj, $body, [\%headers])

Mails a message via M<Mail::Sendmail>. Designed to mimic PHP's mail() function.

\%headers is a list of overrides for the normal email headers.

=cut

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

# use trickery to determine position
sub pos {
	my ($lat, $lon, $parent, $cgi, $session) = @_;

	# step 1: determine from given coordinates
	my $pos;
	if (&is_numeric($lat, $lon)) {
		$pos = [$lat, $lon];
		$session->param('lastpos', $pos);
		return $pos;
	}

	# step 2: determine from last save coordinates
	$pos = $session->param('lastpos');
	return $pos if defined $pos;

	# step 3: determine from IP address
	if ($parent->cfgvar('options', 'enable_geoip')) {
		my $cli_addr = $cgi->remote_addr;
		unless (defined $cli_addr and $cli_addr !~ /^(127\.0\.0\.1|192\.168\.|10\.0)/) {
			# local network address, can't use it
			return undef;
		}

		my $gi;
		# sidestep compilation errors if Geo::IP is not installed
		eval q%
			use Geo::IP;
			$gi = Geo::IP->open($parent->cfgvar('geoip', 'database'), GEOIP_STANDARD);
		%;
		return undef unless defined $gi;

		my $record = $gi->record_by_addr($cli_addr);
		$pos = [ $record->latitude, $record->longitude ] if defined $record;

		$session->param('lastpos', $pos);
	}

	return $pos;
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
