window.crumbsMap = {
	mapOptions: {
		zoom: 16,
		center: null,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
	},

	init: function () {
		this.draw();
	},

	draw: function () {
		var self = this;
		if (self.mapOptions.center) {
			self.map = new google.maps.Map(document.getElementById('map'), self.mapOptions);
		} else {
			// oops, need to get location information
			self._queryGeo(function (success) {
				self.map = new google.maps.Map(document.getElementById('map'), self.mapOptions);
			});
		}
	},

	_queryGeo: function (cb) {
		var self = this;
		window.geo.getImmediate(
			// successful query - may be delayed
			function (pos) {
				self._setcenter(pos);
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
			},
			// first run - may be stored
			function (pos) {
				self._setcenter(pos);
				self.dbgmsg('got location: ' + pos);
				self.draw();
				self.dbgmsg('drew map');
				if (cb) {
					cb(true);
				}
			}
		);
	},

	_setcenter: function (pos) {
		if (pos) {
			this.mapOptions.center = new google.maps.LatLng(pos.latitude, pos.longitude);
		}
	},

	dbgmsg: function (msg) {
		var dbg = $('#debug');
		dbg.append($('<div></div>').text(msg));
	},
};
