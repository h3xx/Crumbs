// Crumbs asynchronous API
//
// Just handles communication
var Crumbs = {
	servlet: '/c',
	options: {
		list: {
			limit: 10,
		},
	},

	list: function (pos, cb) {
		var self = this;
		$.get(
			self.servlet,
			{
				a: 'list',
				lat: pos.latitude,
				lon: pos.longitude,
				//un: fromUser // (not implemented... yet)
				l: self.options.list.limit, 
			},
			cb // success callback
		);
	},

	get: function (id, cb) {
		var self = this;
		$.get(
			self.servlet,
			{
				a: 'get',
				id: id,
			},
			cb // success callback
		);
	},

	put: function (pos, msg, time, reply_to, cb) {
		var self = this;
		$.get(
			self.servlet,
			{
				a: 'put',
				lat: pos.latitude,
				lon: pos.longitude,
				msg: msg,
				time: time,
				reply_to: reply_to,
			},
			cb
		);
	},
};
