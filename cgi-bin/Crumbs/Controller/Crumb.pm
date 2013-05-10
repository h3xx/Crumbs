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

# post a crumb
sub put {
	my ($self, $lat, $lon, $stickpole) = @_;
	my $uid = $self->{'session'}->param('user_id');

	return {
		'result'=> 0,
		'msg'	=> 'You are not logged in.',
	} unless defined $uid;

	# get position
	require Crumbs::Tools;
	my $pos = &Crumbs::Tools::pos($lat, $lon, @{$self}{qw/ parent cgi session /});
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


=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;

