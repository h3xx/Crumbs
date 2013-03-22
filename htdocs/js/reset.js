$(document).ready(function () {
	var
	emsub = $('#emsub'),
	email = $('#email'),
	result = $('#result'),
	frmelems = $([]).add(emsub).add(email),

	pbar = $("#progressbar")
		.append($('<div>Working...</div>').addClass('progress-label'))
		.progressbar({
			value: false,
		})
		.hide();

	frmelems
		.change(function (e) {
			var self = $(this);
			if (!self.val()) {
				self.addClass('ui-state-error');
			} else {
				self.removeClass('ui-state-error');
			}
		});

	emsub
		.button()
		.click(function(e) {
			e.preventDefault();

			frmelems.attr('disabled', 'disabled')
				.removeClass('ui-state-error');
			emsub.addClass('ui-button-disabled ui-state-disabled');

			pbar.show(500);

			$.get('u', {
				'a': 'reset',
				'e': email.val(),
			}, function (data) {
				if (data.url) {
					alert(data.url);
				}
				pbar.hide(500);
				email.val(null);
				result.text(data.msg);
				if (!data.result) {
					frmelems.removeAttr('disabled');
					emsub.removeClass('ui-button-disabled ui-state-disabled');
				}
			});
		});
});
