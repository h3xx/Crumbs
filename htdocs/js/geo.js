window.geo = {
	last: null,
	error: true,
	errorStr: null,
	bsKey: 'last-position',	// what key to use for browser storage
	options: {
		timeout: 60000,
	},

	get: function (successCb, errorCb) {
		var self = this;

		navigator.geolocation.getCurrentPosition(
			function (pos) {
				// gotPosition will return false on error
				if (self.gotPosition(pos)) {
					if (successCb) {
						successCb(self.last);
					}
				} else {
					if (errorCb) {
						errorCb(self.errorStr);
					}
				}
			},
			function (err) {
				self.errorGettingPosition(err);
				if (errorCb) {
					errorCb(self.errorStr);
				}
			},
			{
				'enableHighAccuracy': true,
				'timeout': self.options.timeout,
				'maximumAge': 0,
			}
		);
	},

	loadLast: function () {
		var lastParams = window.localStorage.getItem(this.bsKey);
		if (lastParams) {
			this.last = $.parseJSON(lastParams);
		}
	},

	saveLast: function () {
		if (this.last) {
			var lastParams = JSON.stringify(this.last);
			window.localStorage.setItem(this.bsKey, lastParams);
		}
	},

	/**
	 * Listing 1: Requesting geolocation data
	 *
	 * If the user grants permission and geolocation data is
	 * acquired successfully, the success handler function defined
	 * in the first parameter will be called and will pass in a
	 * position object shown in listing 2. The position object
	 * contains position, altitude, accuracy, heading and speed
	 * information.
	 */
	gotPosition: function (pos) {
		var self = this;

		if (pos && pos.coords) {
			if (self.last == null) {
				self.last = {};
			}
			$.extend(self.last, pos.coords);
			// remove unnecessary bits
			delete self.last.QueryInterface;
			self.saveLast();
			self.error = false;
			return true;
		} else {
			self.error = true;
			self.errorStr = 'No position given.';
			return false;
		}
	},

	/**
	 * Listing 2: Getting GPS Data.
	 *
	 * If there is a problem acquiring geolocation information, the
	 * error function will be called with an error object passed as
	 * a parameter. The error object contains a code property that
	 * defines the basic type of error along with a message
	 * describing the error seen in listing 3.
	 */
	errorGettingPosition: function (err) {
		var self = this;
		self.error = true;
		switch (err.code) {
			case 1:
				self.errorStr = 'User denied geolocation.';
				break;
			case 2:
				self.errorStr = 'Position unavailable.';
				break;
			case 3:
				self.errorStr = 'Timeout expired.';
				break;
			default:
				self.errorStr = 'ERROR:' + err.message;
				break;
		}
	},
};

window.geo.loadLast();
