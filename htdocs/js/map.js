window.crumbsMap = {
	mapOptions: {
		zoom: 16,
		center: null,
	},
	staticOptions: {
		zoom: 13,
	},

	init: function () {
		this.mapOptions.mapTypeId = google.maps.MapTypeId.ROADMAP;
	},

	queryDraw: function (target) {
		// XXX : deprecated; data should come from outside
		var self = this;
		if (self.mapOptions.center) {
			self.map = new google.maps.Map(target, self.mapOptions);
		} else {
			// oops, need to get location information
			self._queryGeo(function (success) {
				self.map = new google.maps.Map(target, self.mapOptions);
			});
		}
	},

	draw: function (target, pos) {
		var self = this;
		self._setCenter(pos);

		self.map = new google.maps.Map(target, self.mapOptions);
	},

	drawstatic: function (target, pos, width, height) {
		var self = this,
		imgSrc = '//maps.googleapis.com/maps/api/staticmap?center='+pos.latitude+','+pos.longitude+
			'&zoom='+self.staticOptions.zoom+
			'&size='+width+'x'+height+
			'&sensor=false';

		target.attr('src', imgSrc);
	},

	addmarker: function (lat, lon, title) {
		var self = this;
		if (self.map) {
			new google.maps.Marker({
				position: new google.maps.LatLng(lat, lon),
				map: self.map,
				title: title,
			});
		}
	},

	_queryGeo: function (cb) {
		// XXX : deprecated; data should come from outside
		var self = this;
		window.geo.get(
			// successful query - may be delayed
			function (pos) {
				self._setCenter(pos);
				self.dbgmsg('got location: ' + pos);
				if (cb) {
					cb(true);
				}
			},
			// error - handle later
			function (msg) {
				alert(msg + ' Please make sure you enable GPS, etc.');
				if (cb) {
					cb(false);
				}
			}
			/*,
			// first run - may be stored
			function (pos) {
				self._setCenter(pos);
				self.dbgmsg('got location: ' + pos);
				if (cb) {
					cb(true);
				}
			}*/
		);
	},

	_setCenter: function (pos) {
		if (pos) {
			this.mapOptions.center = new google.maps.LatLng(pos.latitude, pos.longitude);
		}
	},

	dbgmsg: function (msg) {
		var dbg = $('#debug');
		dbg.append($('<div></div>').text(msg));
	},
};

$(document).ready(function () {window.crumbsMap.init();});
