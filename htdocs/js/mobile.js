$(document).ready(function () {

	$('#mobsite')
	.append(
		$('<div data-role="page"></div>')
		.append(
			$('<div data-role="header">Account</div>'),
			$('<a href="/login?m=" data-rel="dialog">Login</a>')
		)
		.show(),
		$('<div data-role="page"></div>')
		.append(
			$('<div data-role="header">Crumbs</div>'),
			$('<a href="/post?m=" data-rel="dialog">Post</a>')
		)
		
	);
});
