package Crumbs::Controller::User;
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

# --- USER METHODS ---

sub login {
	my ($self, $un, $pw) = @_;

	my $uid = $self->{'model'}->user->login($un, $pw);

	unless ($uid) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to log in.',
		};
	}

	$self->{'session'}->param('user_name', $un);
	$self->{'session'}->param('user_id', $uid);

	return {
		'result'=> 1,
		'msg'	=> 'Successfully logged in.',
	};
}

sub signup {
	my ($self, $un, $em, $pw) = @_;

	my $vfy = $self->{'model'}->user->signup($un, $em, $pw);
	
	unless ($vfy) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to sign up.',
		};
	}

	require Crumbs::Tools;
	return {
		'result'=> 1,
		'url'	=> Crumbs::Tools::vfy_url($self->{'cgi'}, $un, $vfy),
		'msg'	=> 'Successfully signed up.',
	};

}

sub verify {
	my ($self, $un, $vfy) = @_;

	my $uid = $self->{'model'}->user->verify($un, $vfy);
	unless ($uid) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to verify your account.',
		};
	}

	$self->{'session'}->param('user_name', $un);
	$self->{'session'}->param('user_id', $uid);

	return {
		'result'=> 1,
		'msg'	=> 'Successfully verified your account.',
	};
}

sub reset {
	my ($self, $em) = @_;

	my $un = $self->{'model'}->user->resolve_username_from_email($em);

	my $rst = $self->{'model'}->user->reset($un);
	unless ($rst) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to request a password reset.',
		};
	}

	require Crumbs::Tools;
	return {
		'result'=> 1,
		'url'	=> Crumbs::Tools::rst_url($self->{'cgi'}, $un, $rst),
		'msg'	=> 'Successfully requested a password reset.',
	};
}

sub setpw {
	my ($self, $un, $rst, $pw) = @_;

	my $uid = $self->{'model'}->user->setpw($un, $rst, $pw);
	unless ($uid) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to set your password.',
		};
	}

	$self->{'session'}->param('user_name', $un);
	$self->{'session'}->param('user_id', $uid);

	require Crumbs::Tools;
	return {
		'result'=> 1,
		'msg'	=> 'Successfully set new password.',
	};
}

sub logout {
	my $self = shift;

	$self->{'session'}->clear('user_id');

	return {
		'result'=> 1,
		'msg'	=> 'Successfully logged out.',
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
