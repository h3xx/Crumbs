package Crumbs;
use strict;
use warnings;

our $VERSION = '0.01';

use CGI::Session		qw//;
use Config::General		qw//;

sub new {
	my $class = shift;

	my $self = bless {
		#'content-type'	=> 'text/plain',
		'content-type'	=> 'application/json', # later
		@_,
	}, $class;

	$self->_loadcfg;

	$self->_initsession;

	$self
}

# --- CONFIG METHODS ---

sub _loadcfg {
	my $self = shift;
	my $rc = $self->{'rcfile'};

	die 'No configuration file specified.'
		unless $rc;

	#$self->{'cfg'} = Config::General->new($rc)->getall;
	my %cf = Config::General->new($rc)->getall;
	$self->{'cfg'} = \%cf;
}

sub cfgvar {
	my ($self, $var) = @_;

	$self->{'cfg'}->{$var}
}

# --- SESSION METHODS ---

sub _initsession {
	my $self = shift;

	# let's hope this is portable
	$self->{'session'} = CGI::Session->load(undef, $self->{'cgi'}, undef)
		or die CGI::Session->errstr;

	$self->{'session'}->new
		unless defined $self->{'session'}->id;
}

sub _destroysession {
	my $self = shift;

	# save session
	$self->{'session'}->save_param
		if defined $self->{'session'};
}

sub sessvar {
	my ($self, $var, $val) = @_;

	# set the value if defined, else get value
	defined $val ?
		$self->{'session'}->param($var, $val) :
		$self->{'session'}->param($var)
}

sub sesscookie {
	my $self = shift;

	$self->{'session'}->cookie
}

# --- INITIALIZER METHODS ---

sub model {
	my $self = shift;
	use Crumbs::Model;

	$self->{'model'} || (
		$self->{'model'} = Crumbs::Model->new(
			'cgi'	=> $self->{'cgi'},
			'cfg'	=> $self->{'cfg'},
			'session'=> $self->{'session'},
		)
	);
}

sub controller {
	my $self = shift;
	use Crumbs::Controller;

	$self->{'controller'} || (
		$self->{'controller'} = Crumbs::Controller->new(
			'cgi'	=> $self->{'cgi'},
			'model'	=> $self->model,
			'session'=> $self->{'session'},
		)
	);
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

sub DESTROY {
	my $self = shift;

	$self->_destroysession;
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;