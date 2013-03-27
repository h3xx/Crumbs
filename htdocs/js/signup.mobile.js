$(document).ready(function () {
	var
	sform = $('#signupform'),
	usub = $('#usub'),
	name = $('#name'),
	email = $('#email'),
	pass = $('#pass'),
	passv = $('#passv'),

	result = $('#result'),
	okbtn = $('#okbtn'),

	frmelems = $([]).add(name).add(email).add(pass).add(passv),
	passelems = $([]).add(pass).add(passv);

	passelems
		.change(function (e) {
			if (pass.val() && passv.val()) {
				if (pass.val() != passv.val()) {
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

	frmelems
		.change(function (e) {
			var self = $(this);
			if (!self.val()) {
				self.addClass('ui-state-error');
			} else {
				self.removeClass('ui-state-error');
			}
		});

	sform
		.submit(function(e) {
			e.preventDefault();
			if (!name.val()) {
				result.text('User name required.');
				name.addClass('ui-state-error');
				return false;
			} else if (!email.val()) {
				result.text('Email required.');
				email.addClass('ui-state-error');
				return false;
			} else if (!pass.val()) {
				result.text('Password required.');
				pass.addClass('ui-state-error');
				return false;
			} else if (pass.val() != passv.val()) {
				result.text('Passwords do not match.');
				passelems.addClass('ui-state-error');
				return false;
			}

			frmelems.attr('disabled', 'disabled')
				.removeClass('ui-state-error');
			usub.attr('disabled', 'disabled')
			.addClass('ui-button-disabled ui-state-disabled');

			$.get('u', {
				'a': 'signup',
				'u': name.val(),
				'p': pass.val(),
				'e': email.val(),
			}, function (data) {
				result.text(data.msg);
				if (!data.result) {
					frmelems.removeAttr('disabled');

					usub.removeAttr('disabled')
					.removeClass('ui-button-disabled ui-state-disabled');
				} else {
					sform.hide(500);
				}
			});

			return false;
		});
});
