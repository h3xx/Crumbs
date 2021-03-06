$(document).ready(function () {

	var
	loform = $('#logoutform'),
	cancel = $('#cancel').button(),
	logout = $('#logout').button(),
	result = $('#result'),
	okbtn = $('#okbtn').hide(),

	pbar = $('#progressbar')
		.append($('<div>Working...</div>').addClass('progress-label'))
		.progressbar({
			value: false,
		})
		.hide();

	loform
		.submit(function(e) {
			e.preventDefault();
			pbar.show(500);

			$.get('u', {
				'a': 'logout',
			}, function (data) {
				pbar.hide(500);
				result.text(data.msg);
				if (data.result) {
					// hide now-inaccurate data
					lia.hide();
				}
			});

			return false;
		});
});
