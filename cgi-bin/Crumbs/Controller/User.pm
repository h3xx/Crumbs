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

	require Crumbs::Tools;
	if (!&Crumbs::Tools::is_valid_email($em)) {
		return {
			'result'=> 0,
			'msg'	=> 'Invalid email address.',
		};
	}

	my $vfy = $self->{'model'}->user->signup($un, $em, $pw);
	
	unless ($vfy) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to sign up.',
		};
	}

	my $url = &Crumbs::Tools::vfy_url($self->{'cgi'}, $un, $vfy);

	my %success = (
		'result'=> 1,
		'msg'	=> 'Successfully signed up.',
	);

	unless (
		$self->{'parent'}->cfgvar('options', 'can_mail') &&
		&Crumbs::Tools::mail(
			# to
			$em,
			# from
			$self->{'parent'}->cfgvar('options', 'from_email'),
			# subject
			'Verify your Crumbs account',
			# body
			'<p>Please <a href="'.$url.'">click here</a> to verify your crumbs account.</p>',
			# headers?
		)
	) {
		$success{'msg'} .= ' Unable to send verification email though; go here to verify your account: ' . $url;
		$success{'url'} = $url;
	} else {
		$success{'msg'} .= ' Check your email for verification instructions.';
	}

	\%success
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

	my $url = &Crumbs::Tools::rst_url($self->{'cgi'}, $un, $rst),

	my %success = (
		'result'=> 1,
		'msg'	=> 'Successfully requested a password reset.',
	);

	unless (
		$self->{'parent'}->cfgvar('options', 'can_mail') &&
		&Crumbs::Tools::mail(
			# to
			$em,
			# from
			$self->{'parent'}->cfgvar('options', 'from_email'),
			# subject
			'Reset your Crumbs password',
			# body
			'<p>Please <a href="'.$url.'">click here</a> reset your password.</p>',
			# headers?
		)
	) {
		$success{'msg'} .= ' Unable to send password reset email though; go here to reset your password: ' . $url;
		$success{'url'} = $url;
	} else {
		$success{'msg'} .= ' Check your email for instructions.';
	}

	\%success
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
