$(document).ready(function () {
	var
	pwform = $('#pwresetform'),
	pwsub = $('#pwsub').button(),
	cancel = $('#cancel').button(),
	newpw =	$('#newpw'),
	newpwv = $('#newpwv'),
	u = $('#u'),
	r = $('#r'),
	result = $('#result'),
	okbtn = $('#okbtn').hide(),

	frmelems = $([]).add(pwsub).add(newpw).add(newpwv),
	passelems = $([]).add(newpw).add(newpwv),

	pbar = $("#progressbar")
		.append($('<div>Working...</div>').addClass('progress-label'))
		.progressbar({
			value: false,
		})
		.hide();

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
					passelems
						//.removeClass('ui-state-highlight')
						.addClass('ui-state-error');
				} else {
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

			pbar.show(500);

			$.get('u', {
				'a': 'setpw',
				'u': u.val(),
				'r': r.val(),
				'p': newpw.val(),
			}, function (data) {
				pbar.hide(500);
				newpw.val(null);
				newpwv.val(null);
				result.text(data.msg);
				if (!data.result) {
					frmelems.removeAttr('disabled');
					pwsub.removeClass('ui-button-disabled ui-state-disabled');
				}
			});

			return false;
		});
});
