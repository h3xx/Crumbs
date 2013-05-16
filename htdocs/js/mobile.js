$(document).ready(function () {

	function navbar_header (selected_id) {
		var buttons = {},
		navbar = 
			$('<div data-role="header" data-position="fixed" data-id="nb"></div>')
			.append(
				$('<div data-role="navbar"></div>')
				.append(
					$('<ul></ul>')
					.append(
						$('<li></li>').append(buttons.map = $('<a href="#mappage">Map</a>')),
						$('<li></li>').append(buttons.account = $('<a href="#accountpage">Account</a>'))
					)

				)
			);
		if (buttons[selected_id]) {
			buttons[selected_id]
			.addClass('ui-btn-active ui-state-persist');
		}

		return navbar;
	}



	$('#mobsite')
	.append(
		$('<div data-role="page" id="main"></div>')
		.append(navbar_header('')),
		$('<div data-role="page" id="accountpage"></div>')
		.append(
			navbar_header('account'),
			$('<div data-role="content"></div>')
			.append(
				$('<a href="/login?m=" data-rel="dialog" data-role="button">Login</a>'),
				$('<a href="/signup?m=" data-rel="dialog" data-role="button">Sign up</a>'),
				$('<a href="/logout?m=" data-rel="dialog" data-role="button">Log out</a>')
			)
		),
		$('<div data-role="page" id="mappage"></div>')
		.append(
			navbar_header('map'),
			$('<div data-role="content"></div>')
			.append(
				$('<a href="/post?m=" data-rel="dialog" data-role="button">Post New Crumb</a>'),
				$('<div id="mapcanvas"></div>')
			)
		)
		
	);
});
