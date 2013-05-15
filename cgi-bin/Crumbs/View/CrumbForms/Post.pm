package Crumbs::View::CrumbForms::Post;
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
		@scripts = (@{$self->{'scripts_mob'}}, 'js/geo.js');
		@styles = (@{$self->{'styles_mob'}}, 'css/userform.mobile.css');
		@scripts_body = ('js/post.mobile.js');
	} else {
		@scripts = (@{$self->{'scripts_nomob'}}, 'js/geo.js', 'js/post.js');
		@styles = (@{$self->{'styles_nomob'}}, 'css/userform.css');
	}

	my $content =
q%<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="postform" action="/c" method="get">
<input type="hidden" name="a" value="put" />
<input type="hidden" name="lat" id="lat" />
<input type="hidden" name="lon" id="lon" />%.

(sprintf '<div id="loggedinas">%s</div>',
	$cgi->escapeHTML(
		defined $session->param('user_id') ?
			'You are logged in as ' . $session->param('user_name') :
			'You are not logged in.'
	)
).

# inputs
'<textarea id="crumbbody" maxlength="1024" name="msg" placeholder="Type your message here"></textarea>' .


q%<div>
<input id="postsub" type="submit" value="Post" data-rel="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" onclick="history.back();" />
</div>
</form>%;

	my $footer =
'<div id="linkbar">'.
'</div>';

	my $body =
		# XXX : HACK! - makes this work as a dialog box
		$self->_script(@scripts_body) .
		$self->simplebody('Post New Crumb', $content, $footer);

	$self->simpleform('Post New Crumb', \@scripts, \@styles, $body);

}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
