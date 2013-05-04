var bs = {
	webStorageSupported:
		('localStorage' in window) &&
		window['localStorage'] !== null,

	servlet: 'content.cgi',

	_save: function (id, content) {
		window.localStorage.setItem(id, content);
	},

	_load: function (id) {
		return window.localStorage.getItem(id);
	},

	_getFromServer: function (id, cb) {
		var poop = 
		window.localStorage.getItem('crumbdb');
		var self = this;
		$.get(
			self.servlet,
			{
				'id': id
			},
			function (data) {
				if (data.length) {
					//self.db[id] = data[0];
					self._save(id, data[0]);
					if (cb) {
						cb(id, data[0]);
					}
				}
			}
		);
	},

	getNearby: function (cb) {
		var self = this;

		var foo = $.get('nearby-ids.cgi',{},
		function (data) {
			if (cb) {
				cb(data);
			}
		}
		);

	},

	getCrumb: function (id, cb1, cb2) {
		var l = this._load(id);
		if (l != null) {
			if (cb1) {
				cb1(id, l);
			}
		} else {
			this._getFromServer(id, cb2);
		}
	},
};


$(document).ready(function () {
	var dbg = $('#debug');

	var dbgmsg = function (msg) {
		dbg.append($('<div></div>').text(msg));
	};

	var retrievedCrumb = function (id, cont) {
		dbgmsg('Retrieved crumb from server : ['+id+':'+cont+']');
	};

	var storedCrumb = function (id, cont) {
		dbgmsg('Had stored crumb : ['+id+':'+cont+']');
	};

	var gotNearby = function (nblist) {
		for (var i in nblist) {
			var nb = nblist[i];
			dbgmsg('Got nearby id ' + nb);

			bs.getCrumb(nb, storedCrumb, retrievedCrumb);
		}
	};

	bs.getNearby(gotNearby);

	var x;
});
