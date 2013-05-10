window.crumbsMap = {
	mapOptions: {
		zoom: 16,
		center: null,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
	},
	init: function () {
		this._getcenter(null);
	},
	_drawmap: function () {
		this.map = new google.maps.Map(document.getElementById('map'), this.mapOptions);
	},
	_getcenter: function (cb) {
		var self = this;
		window.geo.getImmediate(
			function (pos) {
				self._setcenter(pos);
				self.dbgmsg('got location: ' + pos);
			},
			// error - handle later
			function (msg) {
				alert(msg);
			},
			function (pos) {
				self._setcenter(pos);
				self.dbgmsg('got location: ' + pos);
				self._drawmap();
				self.dbgmsg('drew map');
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
