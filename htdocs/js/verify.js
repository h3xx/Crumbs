$(document).ready(function () {
	var
	uval = $('#u').val(),
	vval = $('#v').val(),
	result = $('#result'),
	pbar = $("#progressbar")
		.append($('<div>Working...</div>').addClass('progress-label'))
		.progressbar({
			value: false,
		});

	if (!uval || !vval) {
		result.text('No verification strings present (did you click the link in your email)?');
		pbar.hide(500);
	}

	$.get('u', {
		'a': 'verify',
		'u': $('#u').val(),
		'v': $('#v').val(),
	}, function (data) {
		pbar.hide(500);
		if (data) {
			result.text(data.msg);
		} else {
			result.text('No data.');
		}
	});
});
