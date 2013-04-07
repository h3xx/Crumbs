package Crumbs::View::UserForms;
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

sub login {
	my $self = shift;
	my ($cgi, $session) = @{$self}{qw/ cgi session /};

	my (@scripts, @styles, @scripts_body);

	if ($self->{'is_mobile'}) {
		@scripts = (@{$self->{'scripts_mob'}});
		@styles = (@{$self->{'styles_mob'}}, 'css/userform.mobile.css');
		@scripts_body = ('css/login.mobile.js');
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
		&_script(@scripts_body) .
		$self->simplebody('Login', $content, $footer);

	$self->simpleform('Login', \@scripts, \@styles, $body);

}

sub logout {
	my $self = shift;
	my ($cgi, $session) = @{$self}{qw/ cgi session /};

	my (@scripts, @styles, @scripts_body);

	if ($self->{'is_mobile'}) {
		@scripts = (@{$self->{'scripts_mob'}});
		@styles = (@{$self->{'styles_mob'}}, 'css/userform.mobile.css');
		@scripts_body = ('css/logout.mobile.js');
	} else {
		@scripts = (@{$self->{'scripts_nomob'}}, 'js/logout.js');
		@styles = (@{$self->{'styles_nomob'}}, 'css/userform.css');
	}

	my $content =
q%<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="logoutform" action="/u" method="get">
<input type="hidden" name="a" value="logout" />%.

(sprintf '<div id="loggedinas">%s</div>',
	$cgi->escapeHTML(
		defined $session->param('user_id') ?
			'You are logged in as ' . $session->param('user_name') :
			'You are not logged in.'
	)
).

q%<input id="logout" type="submit" value="Logout" data-role="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" onclick="history.back();" />
</form>%;

	my $footer = sprintf
'<div id="linkbar">'.
'<span id="gotologin"><a href="login%s" id="loginlink" data-role="button" data-inline="true">Log in again</a></span>'.
'</div>',
			($self->{'is_mobile'} ? '?m=' : '');

	my $body =
		# XXX : HACK! - makes this work as a dialog box
		&_script(@scripts_body) .
		$self->simplebody('Logout', $content, $footer);

	$self->simpleform('Logout', \@scripts, \@styles, $body);
}

sub pwreset {
	my $self = shift;
	my ($cgi, $session) = @{$self}{qw/ cgi session /};

	my (@scripts, @styles, @scripts_body);

	if ($self->{'is_mobile'}) {
		@scripts = (@{$self->{'scripts_mob'}});
		@styles = (@{$self->{'styles_mob'}}, 'css/userform.mobile.css');
		@scripts_body = ('css/pwreset.mobile.js');
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
		&_script(@scripts_body) .
		$self->simplebody('Password Reset', $content, $footer);

	$self->simpleform('Password Reset', \@scripts, \@styles, $body);
}

sub reset {
	my $self = shift;
	my ($cgi, $session) = @{$self}{qw/ cgi session /};

	my (@scripts, @styles, @scripts_body);

	if ($self->{'is_mobile'}) {
		@scripts = (@{$self->{'scripts_mob'}});
		@styles = (@{$self->{'styles_mob'}}, 'css/userform.mobile.css');
		@scripts_body = ('css/reset.mobile.js');
	} else {
		@scripts = (@{$self->{'scripts_nomob'}}, 'js/reset.js');
		@styles = (@{$self->{'styles_nomob'}}, 'css/userform.css');
	}

	my $content =
q%<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="resetform" action="/u" method="get">
<input type="hidden" name="a" value="reset" />%.

(sprintf '<input id="email" type="text" name="e" placeholder="Enter your email address" value="%s" />',
	$cgi->escapeHTML($cgi->param('e') || '')
).

q%<input id="emsub" type="submit" value="Submit" data-rel="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" onclick="history.back();" />
</form>%;

	my $footer = '';

	my $body =
		# XXX : HACK! - makes this work as a dialog box
		&_script(@scripts_body) .
		$self->simplebody('Password Reset Request', $content, $footer);

	$self->simpleform('Password Reset Request', \@scripts, \@styles, $body);
}

sub signup {
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
	(defined $cgi->param('m') ? '?m=' : '') x 2;

	my $body =
		# XXX : HACK! - makes this work as a dialog box
		&_script(@scripts_body) .
		$self->simplebody('Sign-Up', $content, $footer);

	$self->simpleform('Sign-Up', \@scripts, \@styles, $body);
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
		&_stylesheet(@{$self->{'styles_always'}}, @{$styles}),
		&_script(@{$self->{'scripts_always'}}, @{$scripts}),
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
	join '', (map { sprintf '<link rel="stylesheet" type="text/css" href="%s" />', $_ } @_)
}

sub _script {
	join '', (map { sprintf '<script type="text/javascript" src="%s"></script>', $_ } @_)
}

sub _headertitle {
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
