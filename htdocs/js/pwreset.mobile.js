$(document).ready(function () {
	var
	pwform = $('#pwresetform'),
	pwsub = $('#pwsub').button(),
	newpw =	$('#newpw'),
	newpwv = $('#newpwv'),
	u = $('#u'),
	r = $('#r'),
	result = $('#result'),
	okbtn = $('#okbtn').hide(),

	frmelems = $([]).add(pwsub).add(newpw).add(newpwv),
	passelems = $([]).add(newpw).add(newpwv);

	if (!u.val() || !r.val()) {
		frmelems.attr('disabled', 'disabled');
		result.text('No data for password reset (did you click the link in your email?)');
	}

	frmelems
		.change(function (e) {
			var self = $(this);
			if (!self.val()) {
				self.addClass('ui-state-error');
			} else {
				self.removeClass('ui-state-error');
			}
		});

	passelems
		.change(function (e) {
			if (newpw.val() && newpwv.val()) {
				if (newpw.val() != newpwv.val()) {
					result.text('Passwords do not match.');
					passelems
						//.removeClass('ui-state-highlight')
						.addClass('ui-state-error');
				} else {
					result.text('');
					passelems
						//.addClass('ui-state-highlight')
						.removeClass('ui-state-error');
				}
			}
		});

	pwform
		.submit(function(e) {
			e.preventDefault();
			if (newpw.val() != newpwv.val()) {
				result.text('Passwords do not match.');
				passelems.addClass('ui-state-error');
				return false;
			}

			frmelems.attr('disabled', 'disabled')
				.removeClass('ui-state-error');
			pwsub.addClass('ui-button-disabled ui-state-disabled');

			$.get('u', {
				'a': 'setpw',
				'u': u.val(),
				'r': r.val(),
				'p': newpw.val(),
			}, function (data) {
				newpw.val(null);
				newpwv.val(null);
				result.text(data.msg);
				if (!data.result) {
					frmelems.removeAttr('disabled');
					pwsub.removeClass('ui-button-disabled ui-state-disabled');
				} else {
					pwform.hide(500);
					okbtn.show();
				}
			});

			return false;
		});
});
