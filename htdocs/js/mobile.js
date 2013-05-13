$(document).ready(function () {

	var navbar = 
		$('<div data-role="footer" data-position="fixed" id="nb"></div>')
		.append(
			$('<div data-role="navbar"></div>')
			.append(
				$('<ul></ul>')
				.append(
					$('<li><a href="#map">Map</a></li>'),
					$('<li><a href="#account">Account</a></li>')
				)

			)
		);

	$('#mobsite')
	.append(
		$('<div data-role="page" id="main"></div>')
		.append(navbar),
		$('<div data-role="page" id="account"></div>')
		.append(
			$('<div data-role="header" data-id="foo"><h1>Account</h1></div>'),
			$('<div data-role="content"></div>')
			.append(
				$('<a href="/login?m=" data-rel="dialog" data-role="button">Login</a>'),
				$('<a href="#map" data-role="button" class="ui-state-persist">Poop</a>')
			),
			navbar.clone()

		),
		$('<div data-role="page" id="map"></div>')
		.append(
			$('<div data-role="header" data-id="foo"></div>'),
			$('<div data-role="content"></div>')
			.append(
				$('<a href="/post?m=" data-rel="dialog">Post</a>')
			),
			navbar.clone()
		)
		
	);
});
