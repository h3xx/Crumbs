package Crumbs::Model::User;
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

# --- ACTIONS ---

sub login {
	my ($self, $un, $pw) = @_;

	return 0 unless defined $un and defined $pw;

	my $q = $self->{'db'}->prepare('select user_check_login(?,?)');

	return 0 unless $q->execute($un, $pw);

	($q->fetchrow_array)[0]
}

sub signup {
	my ($self, $un, $em, $pw) = @_;

	return 0 unless defined $un and defined $em and defined $pw;

	my $q = $self->{'db'}->prepare('select user_new_login(?,?,?)');

	return 0 unless $q->execute($un, $em, $pw);

	($q->fetchrow_array)[0]
}

sub verify {
	my ($self, $un, $vfy) = @_;

	return 0 unless defined $un and defined $vfy;

	my $q = $self->{'db'}->prepare('select user_verify(?,?)');

	return 0 unless $q->execute($un, $vfy);

	($q->fetchrow_array)[0]
}

sub reset {
	my ($self, $un) = @_;

	return 0 unless defined $un;

	my $q = $self->{'db'}->prepare('select user_set_reset(?)');

	return 0 unless $q->execute($un);

	($q->fetchrow_array)[0]
}

sub setpw {
	my ($self, $un, $rst, $pw) = @_;

	return 0 unless defined $un and defined $rst and defined $pw;

	my $q = $self->{'db'}->prepare('select user_take_reset(?,?,?)');

	return 0 unless $q->execute($un, $rst, $pw);

	($q->fetchrow_array)[0]
}

# --- QUERIES ---

sub resolve_username_from_email {
	my ($self, $em) = @_;

	my $q = $self->{'db'}->prepare('select "user_name" from "user" where "user_email" = ?');

	return 0 unless $q->execute($em);

	($q->fetchrow_array)[0]
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
