package Crumbs::View::UserForms::SimpleForm;
use strict;
use warnings;

our $VERSION = '0.01';

sub new {
	my $class = shift;

	my $self = bless {
		'doctype'	=> '<!DOCTYPE html>',
		'head_always'	=> '<meta name="viewport" content="width=device-width, initial-scale=1" />',
		'scripts_always'=> ['js/jq/jquery-1.9.1.min.js'],
		'scripts_mob'	=> ['js/jq/jquery.mobile-1.3.0.min.js'],
		'scripts_nomob'	=> ['js/jq/jquery-ui-1.10.2.min.js'],
		'styles_mob'	=> ['css/jquery.mobile-1.3.0.min.css'],
		'styles_nomob'	=> ['css/jquery-ui-1.10.2.min.css'],
		@_,
	}, $class;

	$self->{'is_mobile'} = defined $self->{'cgi'}->param('m');

	$self
}

sub simpleform {
	my ($self, $title, $scripts, $styles, $body) = @_;

	sprintf '%s
<html>
<head>
<title>%s</title>
%s
%s%s</head>
<body>
%s
</body>
</html>',
		$self->{'doctype'},
		$title,
		$self->{'head_always'},
		$self->_stylesheet(@{$self->{'styles_always'}}, @{$styles}),
		$self->_script(@{$self->{'scripts_always'}}, @{$scripts}),
		$body
}

sub simplebody {
	my ($self, $headertitle, $content, $footer) = @_;

	sprintf '<div data-role="header"><h1>%s</h1></div>
<div data-role="content">%s</div>
<div data-role="footer">%s</div>',
		$headertitle, $content, $footer
}

sub _stylesheet {
	my $self = shift;
	join '', (map { sprintf '<link rel="stylesheet" type="text/css" href="%s" />', $_ } @_)
}

sub _script {
	my $self = shift;
	join '', (map { sprintf '<script type="text/javascript" src="%s"></script>', $_ } @_)
}

sub _headertitle {
	my $self = shift;
	sprintf '<div data-role="header"><h1>%s</h1></div>', $_[0]
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
