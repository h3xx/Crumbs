$(document).ready(function () {

	var lia =
		$('#loggedinas')
		.text('Getting your user info.'),

	logout = $('#logout'),

	pbar = $('#progressbar')
		.append($('<div>Working...</div>').addClass('progress-label'))
		.progressbar({
			value: false,
		})
		.hide();

	$.get('u',
		{
			'a': 'whoami',
		}, function (data) {
			if (data) {
				if (!data.name && !data.result) {
					// uh-oh, not logged in?
					lia.text(data.msg);
					logout.attr('disabled', 'disabled');
				} else {
					lia.text('You are logged in as ' + data.name);
				}
			} else {
				lia.text('Failure');
			}
		});

	logout
		.button()
		.click(function(e) {
			e.preventDefault();
			pbar.show(500);

			$.get('u', {
				'a': 'logout',
			}, function (data) {
				pbar.hide(500);
				$('#result').text(data.msg);
				if (data.result) {
					// hide now-inaccurate data
					lia.hide();
				}
			});
		});
});
