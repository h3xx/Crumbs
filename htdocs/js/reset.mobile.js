$(document).ready(function () {
	var
	rform = $('#resetform'),
	emsub = $('#emsub').button(),
	email = $('#email'),
	result = $('#result'),
	okbtn = $('#okbtn').hide(),
	frmelems = $([]).add(emsub).add(email);

	rform
		.submit(function(e) {
			e.preventDefault();

			frmelems.attr('disabled', 'disabled')
				.removeClass('ui-state-error');
			emsub.addClass('ui-button-disabled ui-state-disabled');

			$.get('u', {
				'a': 'reset',
				'e': email.val(),
			}, function (data) {
				if (data.url) {
					alert(data.url);
				}
				email.val(null);
				result.text(data.msg);
				if (!data.result) {
					frmelems.removeAttr('disabled');
					emsub.removeClass('ui-button-disabled ui-state-disabled');
				} else {
					rform.hide(500);
				}
			});

			return false;
		});
});
