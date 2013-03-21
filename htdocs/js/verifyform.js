$(document).ready(function () {
	var pbar = $("#progressbar")
		.progressbar({
			value: false,
		});

	$.get('verify', {
		'u': $('#u').val(),
		'v': $('#v').val(),
	}, function (data) {
		pbar.hide(500);
		if (data) {
			$('#result').text(data.msg);
		} else {
			$('#result').text('No data.');
		}
	});
});
