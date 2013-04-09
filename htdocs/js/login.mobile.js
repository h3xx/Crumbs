$(document).ready(function () {
	var
	lform = $('#loginform'),
	login = $('#login').button(),
	pw = $('#pw'),
	logname = $('#logname'),
	result = $('#result'),
	okbtn = $('#okbtn').hide(),
	frmelems = $([]).add(login).add(pw).add(logname);

	lform
		.submit(function(e) {
			e.preventDefault();

			frmelems.attr('disabled', 'disabled');
			result.text('');
			$.mobile.loading('show', {
				text: 'Working...',
			});

			$.get('u',
				{
					'a': 'login',
					'u': logname.val(),
					'p': pw.val(),
				}, function (data) {
					$.mobile.loading('hide');
					result.text(data.msg);
					if (!data.result) {
						frmelems.removeAttr('disabled');
					} else {
						// hide now-inaccurate data
						lform.hide();
						okbtn.show();
					}
				});

			return false;
		});
});
