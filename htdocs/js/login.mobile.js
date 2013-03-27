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

			$('.ui-loader').show();
			frmelems.attr('disabled', 'disabled');

			$.get('u',
				{
					'a': 'login',
					'u': logname.val(),
					'p': pw.val(),
				}, function (data) {
					$('.ui-loader').hide();
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
