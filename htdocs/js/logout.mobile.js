$(document).ready(function () {

	var
	loform = $('#logoutform'),
	logout = $('#logout'),
	result = $('#result'),
	okbtn = $('#okbtn').hide();

	loform
		.submit(function(e) {
			e.preventDefault();

			$.get('u', {
				'a': 'logout',
			}, function (data) {
				result.text(data.msg);
				if (data.result) {
					// hide now-inaccurate data
					loform.hide(500);
					okbtn.show();
				}
			});

			return false;
		});
});
