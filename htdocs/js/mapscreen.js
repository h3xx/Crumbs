$(document).ready(function () {
	var servlet = '/c',
	mapcanvas = $('#mapcanvas')
	// silly UI hack
	.attr('data-role', 'button'),
	updateMap = function () {
		if (window.updateMap_sem || window.dontcareMap) {
			return false;
		}
		window.updateMap_sem = true;

		$.get(servlet, {
			'a':	'list',
			'lat':	window.geo.last.latitude,
			'lon':	window.geo.last.longitude,
		},
		function (data) {
			if (data.result) {
				for (var i in data.list) {
					var buf = data.list[i];
					window.crumbsMap.addmarker(buf[2], buf[3], buf[0]);
				}
			}
			//window.crumbsMap.draw(mapcanvas[0], window.geo.last);
			window.updateMap_sem = false;
		});
	},
	updateGeo = function () {
		if (window.updateGeo_sem || window.dontcareGeo) {
			return false;
		}
		window.updateGeo_sem = true;

		window.geo.get(
			function (pos) {
				updateMap();
				window.updateGeo_sem = false;
			},
			function (err) {
				window.updateGeo_sem = false;
			}
		);
	};

	$('#mappage')
	.on('pageshow', function () {
		window.dontcateMap = false;
		window.dontcateGeo = false;

		window.crumbsMap.draw(mapcanvas[0], window.geo.last);
		updateGeo();
	})
	.on('pagehide', function () {
		window.dontcateMap = true;
		window.dontcateGeo = true;
	});
/*
	$.get(servlet,
	{
*/
});
