package Crumbs;
use strict;
use warnings;

our $VERSION = '0.01';

require Config::General;

sub new {
	my $class = shift;

	my $self = bless {
		#'content-type'	=> 'text/plain',
		'content-type'	=> 'application/json', # later
		@_,
	}, $class;

	$self
}

# --- CONFIG METHODS ---

sub cfgvar {
	my ($self, $sec, $sub) = @_;

	$sec = $self->cfg->{$sec};
	# we're done if they just want the top section (defined or not)
	return $sec unless defined $sub;

	unless (defined $sec) {
		# user wants configuration variable in section that doesn't exist
		warn "Configuration section $sec doesn't exist.";
		return undef;
	}

	return $sec->{$sub}
}

# --- SESSION METHODS ---

sub sessvar {
	my $self = shift;

	# set the value if defined, else get value
	$self->session->param(@_)
}

sub sesscookie {
	my $self = shift;

	$self->session->cookie
}

# --- INITIALIZER METHODS ---

sub model {
	my $self = shift;
	require Crumbs::Model;

	$self->{'model'} || (
		$self->{'model'} = Crumbs::Model->new(
			'parent'=> $self,
			'db'	=> $self->db,
			'cgi'	=> $self->{'cgi'},
			'session'=> $self->session,
		)
	);
}

sub controller {
	my $self = shift;
	require Crumbs::Controller;

	$self->{'controller'} || (
		$self->{'controller'} = Crumbs::Controller->new(
			'parent'=> $self,
			'cgi'	=> $self->{'cgi'},
			'model'	=> $self->model,
			'session'=> $self->session,
		)
	);
}

sub view {
	my $self = shift;
	require Crumbs::View;

	$self->{'view'} || (
		$self->{'view'} = Crumbs::View->new(
			'parent'=> $self,
			'cgi'	=> $self->{'cgi'},
			'model'	=> $self->model,
			'session'=> $self->session,
		)
	);
}

sub cfg {
	my $self = shift;

	return $self->{'cfg'} if defined $self->{'cfg'};

	my $rc = $self->{'rcfile'};

	die 'No configuration file specified.'
		unless $rc;

	#$self->{'cfg'} = Config::General->new($rc)->getall;
	my %cf = Config::General->new($rc)->getall;
	$self->{'cfg'} = \%cf;
}

sub session {
	my $self = shift;
	require Crumbs::Session;

	$self->{'session'} || (
		$self->{'session'} = Crumbs::Session->new(
			'cgi'	=> $self->{'cgi'},
			'db'	=> $self->db,
		)
	);
}

sub db {
	my $self = shift;
	require Crumbs::Database;

	$self->{'db'} || (
		$self->{'db'} = Crumbs::Database->new(
			'cfg'	=> $self->cfg,
		)
	)
}

# --- GENERAL METHODS ---

sub header {
	my $self = shift;

	$self->{'cgi'}->header(
		'-type'		=> $self->{'content-type'},
		'-charset'	=> 'utf8',
		'-cookie'	=> $self->sesscookie,
	);
}

#sub DESTROY {
#	my $self = shift;
#
#	$self->_destroysession;
#}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
