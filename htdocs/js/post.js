$(document).ready(function () {
	var
	pform = $('#postform'),
	postsub = $('#postsub').button(),
	postbody =
		$('#crumbbody')
		.click(function () {
			postbody.css('height', '133px');
			postbody.css('width', '400px');
		}),
	cancel = $('#cancel').button(),
	georesult = $('<div></div>'),
	statresult = $('<div></div>'),
	result = $('#result').append(georesult, statresult),
	okbtn = $('#okbtn').hide(),
	lath = $('#lat'),
	lonh = $('#lon'),
	frmelems = $([]).add(postsub).add(postbody),

	pbar = $("#progressbar")
		.append($('<div>Working...</div>').addClass('progress-label'))
		.progressbar({
			value: false,
		})
		.hide(),

	// fill geolocation hidden inputs
	fillgeoform = function (cb) {
		window.geo.get(
			// success
			function (pos) {
				georesult.text('Got location.');
				lath.val(pos.latitude);
				lonh.val(pos.longitude);
				if (cb) {
					cb(true);
				}
			},
			// fail
			function (msg) {
				georesult.text(msg);
				if (cb) {
					cb(false);
				}
			}
		);
	};

	// start getting geolocation right away
	georesult.text('Getting geolocation.');
	fillgeoform(null);

	pform
		.submit(function(e) {
			e.preventDefault();

			var lat = lath.val(),
			lon = lonh.val(),
			msg = postbody.val();

			if (!msg) {
				statresult.text('Please add a message.');
				postbody.effect('shake');
				return false;
			}

			pbar.show(500);

			if (!lat || !lon) {
				georesult.text('Geolocation not available yet. Will send when it is available.');

				fillgeoform(function (success) {
					if (success) {
						return pform.submit();
					} else {
						georesult.text('Geolocation unavailable.');
						frmelems.attr('disabled', 'disabled');
					}
				});
				return false;
			}

			frmelems.attr('disabled', 'disabled');

			$.get('c',
				{
					'a': 'put',
					'lat': lat,
					'lon': lon,
					'msg': msg
				}, function (data) {
					pbar.hide(500);
					statresult.text(data.msg);
					if (!data.result) {
						frmelems.removeAttr('disabled');
					}
				});

			return false;
		});
});
