package Crumbs::View::UserForms::Signup;
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
		@scripts_body = ('css/signup.mobile.js');
	} else {
		@scripts = (@{$self->{'scripts_nomob'}}, 'js/signup.js');
		@styles = (@{$self->{'styles_nomob'}}, 'css/userform.css');
	}

	my $content =
q%<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="signupform" action="/u" method="get">
<input type="hidden" name="a" value="signup" />%.

(sprintf '<div><input id="name" type="text" name="u" placeholder="Desired user name" value="%s" /></div>'.
	'<div><input id="email" type="text" name="e" placeholder="Email address" value="%s" /></div>'.
	'<div><input id="pass" type="password" name="p" placeholder="Password" value="%s" />'.
	'<input id="passv" type="password" name="pv" placeholder="Verify password" value="%s" /></div>',
	$cgi->escapeHTML($cgi->param('u') || ''),
	$cgi->escapeHTML($cgi->param('e') || ''),
	$cgi->escapeHTML($cgi->param('p') || ''),
	$cgi->escapeHTML($cgi->param('pv') || '')
).

q%<input id="usub" type="submit" value="Submit" data-rel="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" onclick="history.back();" />
</form>%;

	my $footer = sprintf
'<div id="linkbar">'.
'<span id="gotologin"><a href="login%s" id="loginlink" data-role="button" data-inline="true">Log in</a></span> &middot;'.
'<span id="gotoreset"><a href="reset%s" id="resetlink" data-role="button" data-inline="true">Reset your password</a></span>'.
'</div>',
	($self->{'is_mobile'} ? '?m=' : '') x 2;

	my $body =
		# XXX : HACK! - makes this work as a dialog box
		$self->_script(@scripts_body) .
		$self->simplebody('Sign-Up', $content, $footer);

	$self->simpleform('Sign-Up', \@scripts, \@styles, $body);
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
