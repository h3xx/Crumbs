$(document).ready(function () {

	$('#mobsite')
	.append(
		//window.loginpage.widget(),
		$('<div data-role="page"></div>')
		.append(
			$('<div data-role="header">Header1</div>'),
			$('<a href="/login?m=" data-rel="dialog">Login</a>')
		).show()
		/*
		$('<div data-role="page"></div>')
		.append(
			$('<div data-role="header">Header</div>')
		)*/
	);
});
