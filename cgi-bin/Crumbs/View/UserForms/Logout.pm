package Crumbs::View::UserForms::Logout;
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
		@scripts_body = ('js/logout.mobile.js');
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
		$self->_script(@scripts_body) .
		$self->simplebody('Logout', $content, $footer);

	$self->simpleform('Logout', \@scripts, \@styles, $body);
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
