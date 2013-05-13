$(document).ready(function () {

	var navbar = 
		$('<div data-role="footer" data-position="fixed"></div>')
		.append(
			$('<div data-role="navbar"></div>')
			.append(
				$('<ul>')
				.append(
					$('<li><a href="/account.m">Account</a></li>')
					.addClass('ui-btn-active ui-state-persist'),
					$('<li><a href="#map">Map</a></li>')
				)

			)
		);

	$('#account')
	.append(
		$('<div data-role="header"><h1>Account</h1></div>'),
		$('<div data-role="content"></div>')
		.append(
			$('<a href="/login?m=" data-rel="dialog" data-role="button">Login</a>')
		),
		navbar.clone()
	);
});

