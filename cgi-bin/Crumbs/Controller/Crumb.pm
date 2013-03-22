package Crumbs::Controller::Crumb;
use strict;
use warnings;

our $VERSION = '0.01';

sub new {
	my $class = shift;

	my $self = bless {
		@_,
	}, $class;

	$self
}

sub get {
	my ($self, $lat, $lon, $from_user, $stickpole, $limit) = @_;

	# get position
	my $pos = $self->_pos($lat, $lon);
	unless (defined $pos) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to determine your position.',
		};
	}

	return {
		'result'=> 1,
		'pos'	=> $pos,
		'msg'	=> 'poop',
	};
}

sub put {
	my ($self, $lat, $lon, $stickpole) = @_;

	# get position
	my $pos = $self->_pos($lat, $lon);
	unless (defined $pos) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to determine your position.',
		};
	}

	return {
		'result'=> 1,
		'pos'	=> $pos,
		'msg'	=> 'poop',
	};
}

# use trickery to determine position
sub _pos {
	my ($self, $lat, $lon) = @_;

	require Crumbs::Tools;

	# step 1: determine from given coordinates
	my $pos;
	if (&Crumbs::Tools::is_numeric($lat, $lon)) {
		$pos = [$lat, $lon];
		$self->{'session'}->param('lastpos', $pos);
		return $pos;
	}

	# step 2: determine from last save coordinates
	$pos = $self->{'session'}->param('lastpos');
	return $pos if defined $pos;

	# step 3: determine from IP address
	my $cli_addr = $self->{'cgi'}->remote_addr;

	unless (defined $cli_addr and $cli_addr !~ /^(127\.0\.0\.1|192\.168\.|10\.0)/) {
		# local network address, can't use it
		return undef;
	}

	use Geo::IP;
	my $gi = Geo::IP->open('/usr/share/GeoIP/GeoIPCity.dat', GEOIP_STANDARD);
	my $record = $gi->record_by_addr($cli_addr);
	$pos = [ $record->latitude, $record->longitude ] if defined $record;

	$self->{'session'}->param('lastpos', $pos);
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

