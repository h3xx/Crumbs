/*****
 * Session storage for crumbs.
 */
window.crumbsBs = {

	servlet: '/c',
	bsprefix: 'crumb_',

	_save: function (id, content) {
		window.localStorage.setItem(this.bsprefix + id, JSON.stringify(content));
	},

	_load: function (id) {
		return JSON.parse(window.localStorage.getItem(this.bsprefix + id));
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
					self._save(id, data);
				}
				if (cb) {
					cb(id, data);
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
