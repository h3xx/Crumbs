package Crumbs::View::UserForms::Login;
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
		@scripts_body = ('js/login.mobile.js');
	} else {
		@scripts = (@{$self->{'scripts_nomob'}}, 'js/login.js');
		@styles = (@{$self->{'styles_nomob'}}, 'css/userform.css');
	}

	my $content =
q%<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="loginform" action="/u" method="get">
<input type="hidden" name="a" value="login" />%.

(sprintf '<div id="loggedinas">%s</div>',
	$cgi->escapeHTML(
		defined $session->param('user_id') ?
			'You are logged in as ' . $session->param('user_name') :
			'You are not logged in.'
	)
).

# inputs
(sprintf '<input id="logname" type="text" name="u" placeholder="Username" value="%s" />'.
'<input id="pw" type="password" name="p" placeholder="Password" value="%s" />',
	$cgi->escapeHTML($cgi->param('u') || $session->param('user_name') || ''),
	$cgi->escapeHTML($cgi->param('p') || '')
).


q%<input id="loginsub" type="submit" value="Login" data-rel="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" onclick="history.back();" />
</form>%;

	my $footer = sprintf
'<div id="linkbar">'.
'<span id="gotoreset"><a href="reset%s" id="resetlink" data-role="button" data-inline="true">Reset your password</a></span> &middot;'.
'<span id="gotosignup"><a href="signup%s" id="signuplink" data-role="button" data-inline="true">Sign up</a></span>'.
'</div>',
			($self->{'is_mobile'} ? '?m=' : '') x 2;

	my $body =
		# XXX : HACK! - makes this work as a dialog box
		$self->_script(@scripts_body) .
		$self->simplebody('Login', $content, $footer);

	$self->simpleform('Login', \@scripts, \@styles, $body);

}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
