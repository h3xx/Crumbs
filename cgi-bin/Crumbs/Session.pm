package Crumbs::Session;
use strict;
use warnings;

use constant DRIVER => 'driver:postgresql';

require CGI::Session;

our $VERSION = '0.01';
our @ISA = qw/ CGI::Session /;


sub new {
	my $class = shift;

	my ($cgi, $db, $rcfile) = @{{@_}}{qw/ cgi db rcfile /};

	if (!defined $db and defined $rcfile) {
		use Config::General;
		use Crumbs::Database;
		my %cf = Config::General->new($rcfile)->getall;
		$db = Crumbs::Database->new(
			'cfg'	=> \%cf,
		);
	}

	my $self = bless CGI::Session->new(DRIVER, $cgi, {
		Handle		=> $db->dbi,
		TableName	=> 'session',
		IdColName	=> 'id',
		DataColName	=> 'data',
	}), $class;

	$self->expire('+30d');

	$self
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
