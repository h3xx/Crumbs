$(document).ready(function () {
	var
	lform = $('#loginform'),
	login = $('#loginsub').button(),
	cancel = $('#cancel').button(),
	pw = $('#pw'),
	logname = $('#logname'),
	result = $('#result'),
	okbtn = $('#okbtn').hide(),
	frmelems = $([]).add(login).add(pw).add(logname),

	pbar = $("#progressbar")
		.append($('<div>Working...</div>').addClass('progress-label'))
		.progressbar({
			value: false,
		})
		.hide();

	lform
		.submit(function(e) {
			e.preventDefault();

			frmelems.attr('disabled', 'disabled');
			pbar.show(500);

			$.get('u',
				{
					'a': 'login',
					'u': logname.val(),
					'p': pw.val(),
				}, function (data) {
					pbar.hide(500);
					result.text(data.msg);
					if (!data.result) {
						frmelems.removeAttr('disabled');
					} else {
						// hide now-inaccurate data
						$('#loggedinas').hide();
					}
				});

			return false;
		});
});
