package Crumbs::Tools;
use strict;
use warnings;

our $VERSION = '0.01';

use URI::Escape	qw/ uri_escape_utf8 /;

sub vfy_url {
	my ($cgi, $un, $vfy) = @_;

	sprintf '%s://%s/u?a=verify?u=%s;v=%s',
		$cgi ? ($cgi->https ? 'https' : 'http') : 'poop',
		$ENV{'HTTP_HOST'},
		&uri_escape_utf8($un),
		&uri_escape_utf8($vfy);

}

sub rst_url {
	my ($cgi, $un, $rst) = @_;

	sprintf '%s://%s/u?a=pwreset?u=%s;r=%s',
		$cgi ? ($cgi->https ? 'https' : 'http') : 'poop',
		$ENV{'HTTP_HOST'},
		&uri_escape_utf8($un),
		&uri_escape_utf8($rst);
	
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
