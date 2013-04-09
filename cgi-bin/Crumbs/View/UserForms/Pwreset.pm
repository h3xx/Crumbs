package Crumbs::View::UserForms::Pwreset;
use strict;
use warnings;

our $VERSION = '0.01';

require Crumbs::View::UserForms::SimpleForm;
our @ISA = qw/ Crumbs::View::UserForms::SimpleForm /;

sub content {
	my $self = shift;
	my ($cgi, $session) = @{$self}{qw/ cgi session /};

	my (@scripts, @styles, @scripts_body);

	if ($self->{'is_mobile'}) {
		@scripts = (@{$self->{'scripts_mob'}});
		@styles = (@{$self->{'styles_mob'}}, 'css/userform.mobile.css');
		@scripts_body = ('js/pwreset.mobile.js');
	} else {
		@scripts = (@{$self->{'scripts_nomob'}}, 'js/pwreset.js');
		@styles = (@{$self->{'styles_nomob'}}, 'css/userform.css');
	}

	my $content =
q%<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="pwresetform" action="/u" method="get">
<input type="hidden" name="a" value="setpw" />%.

(sprintf '<input id="u" type="hidden" name="u" value="%s" />'.
	'<input id="r" type="hidden" name="r" value="%s" />',
	$cgi->escapeHTML($cgi->param('u') || ''),
	$cgi->escapeHTML($cgi->param('r') || '')

).

q%<input id="newpw" type="password" name="p" placeholder="Enter a new password" />
<input id="newpwv" type="password" name="pv" placeholder="Verify password" />
<input id="pwsub" type="submit" value="Change" data-rel="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" />
</form>%;

	my $footer = q%<div id="linkbar">
<a href="#" onclick="history.back();" id="gobacklink" data-role="button" data-inline="true">Go back</a>
</div>%;

	my $body =
		# XXX : HACK! - makes this work as a dialog box
		$self->_script(@scripts_body) .
		$self->simplebody('Password Reset', $content, $footer);

	$self->simpleform('Password Reset', \@scripts, \@styles, $body);
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
