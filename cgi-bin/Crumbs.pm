package Crumbs;
use strict;
use warnings;

our $VERSION = '0.01';

use Crumbs::Database	qw//;
use CGI::Session	qw//;

sub new {
	my $class = shift;

	my $self = bless {
		@_,
	}, $class;

	$self->_loadcfg;

	$self->{'db'} = Crumbs::Database->new('cfg'=>$self->{'cfg'});

	$self->session;

	$self
}

sub session {
	my $self = shift;

	$self->{'session'} = CGI::Session->load(undef, $self->{'cgi'}, undef)
		or die CGI::Session->errstr;

	unless ($self->{'session'}->id) {
		$self->{'session'}->new;
	}
}

sub sessvar {
	my ($self, $var, $val) = @_;

	if (defined $val) {
		$self->{'session'}->param($var, $val);
		return $self->{'session'}->save_param;
	} else {
		return $self->{'session'}->param($var);
	}
}

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

sub sesscookie {
	my $self = shift;

	$self->{'session'}->cookie
}

1;
