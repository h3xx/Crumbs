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

# query crumbs in the area
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

	# FIXME

	return {
		'result'=> 1,
		'pos'	=> $pos,
		'msg'	=> 'poop',
	};
}

# query sticking poles in the area
sub pole {
	my ($self, $lat, $lon, $limit) = @_;
	# FIXME
}

# post a crumb
sub put {
	my ($self, $lat, $lon, $stickpole) = @_;
	my $uid = $self->{'session'}->param('user_id');

	return {
		'result'=> 0,
		'msg'	=> 'You are not logged in.',
	} unless defined $uid;

	# get position
	my $pos = $self->_pos($lat, $lon);
	unless (defined $pos) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to determine your position.',
		};
	}

	# caveat re: earthdistance `point' type:
	#
	# Points are taken as (longitude, latitude) and not vice versa because
	# longitude is closer to the intuitive idea of x-axis and latitude to
	# y-axis.
	#
	# Source: http://www.postgresql.org/docs/current/static/earthdistance.html
	#
	# However, the ll_to_earth(float8, float8) function takes (latitude, longitude)

	return {
		'result'=> 1,
		'pos'	=> $pos,
		'msg'	=> 'poop',
	};
}

# delete a crumb
sub del {
	my ($self, $cid) = @_;
	my $uid = $self->{'session'}->param('user_id');

	return {
		'result'=> 0,
		'msg'	=> 'You are not logged in.',
	} unless defined $uid;

	unless ($self->{'model'}->crumb->delete_crumb($uid, $cid)) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to delete crumb.',
		};
	}

	return {
		'result'=> 1,
		'msg'	=> 'Success.',
	};
}

# mark read
sub read {
	my ($self, $cid) = @_;
	my $uid = $self->{'session'}->param('user_id');

	return {
		'result'=> 0,
		'msg'	=> 'You are not logged in.',
	} unless defined $uid;

	unless ($self->{'model'}->crumb->mark_read($uid, $cid)) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to mark crumb as read.',
		};
	}

	return {
		'result'=> 1,
		'msg'	=> 'Success.',
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
	if ($self->{'parent'}->cfgvar('options', 'enable_geoip')) {
		my $cli_addr = $self->{'cgi'}->remote_addr;
		unless (defined $cli_addr and $cli_addr !~ /^(127\.0\.0\.1|192\.168\.|10\.0)/) {
			# local network address, can't use it
			return undef;
		}

		my $gi;
		# sidestep compilation errors if Geo::IP is not installed
		eval q%
			use Geo::IP;
			$gi = Geo::IP->open($self->{'parent'}->cfgvar('geoip', 'database'), GEOIP_STANDARD);
		%;
		return undef unless defined $gi;

		my $record = $gi->record_by_addr($cli_addr);
		$pos = [ $record->latitude, $record->longitude ] if defined $record;

		$self->{'session'}->param('lastpos', $pos);
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

