$(document).ready(function () {
	var pbar = $("#progressbar")
		.append($('<div>Working...</div>').addClass('progress-label'))
		.progressbar({
			value: false,
		});

	$.get('u', {
		'a': 'verify',
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
