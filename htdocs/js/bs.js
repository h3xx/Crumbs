/*****
 * Session storage for crumbs.
 */
window.crumbsBs = {
	webStorageSupported:
		('localStorage' in window) &&
		window['localStorage'] !== null,

	servlet: 'content.cgi', // TODO : dummy script

	_save: function (id, content) {
		window.localStorage.setItem(id, content);
	},

	_load: function (id) {
		return window.localStorage.getItem(id);
	},

	_getFromServer: function (id, cb) {
		var self = this;
		$.get(
			self.servlet,
			{
				'a': 'get',
				'id': id
			},
			function (data) {
				if (data.result) {
					//self.db[id] = data[0];
					self._save(id, data.msg);
					if (cb) {
						cb(id, data.msg);
					}
				}
			}
		);
	},

	getCrumb: function (id, cb) {
		var l = this._load(id);
		if (l != null) {
			if (cb) {
				cb(id, l);
			}
		} else {
			this._getFromServer(id, cb);
		}
	},
};
