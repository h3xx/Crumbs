$(document).ready(function () {

window.loginpage = {
	options: {
		servlet: '/u',
		shown: true,
	},

	loginCallback: function () {
		var self = this;

		if (!self.unInput.val()) {
			self.unInput.addClass('ui-state-error');
			return;
		}

		if (!self.pwInput.val()) {
			self.pwInput.addClass('ui-state-error');
			return;
		}

		self.frmelems
			.removeClass('ui-state-error')
			.attr('disabled', 'disabled');

		self.formHolder.hide(100);
		self.pbar.show(100);
	},

	widget: function () {
		if (!this.loginPage) {
			this._create();
		}
		return this.loginPage;
	},

	_create: function () {
		var self = this,
		options = self.options,

		loginPage = (self.loginPage = $('<div data-role="dialog"></div>'))
			.addClass('ui-loginpage ui-widget-header ui-corner-all')
			.append(
				$('<div data-role="header"><h1>Login</h1></div>')
				.addClass('ui-loginpage-header'),

				self.formHolder = $('<div></div>')
				.append(
					$('<div></div>')
					.append(
						self.unInput =
						$('<input type="text" placeholder="User name" />'),
						self.pwInput =
						$('<input type="password" placeholder="Password" />')
					),
					$('<div></div>')
					.append(
						$('<button>GO</button>')
						.button()
						.click(function () {
							self.loginCallback();
						})
					)
				),

				self.pbar =
				$('<div></div>')
				.addClass('progressbar')
				.append(
					$('<div>Working...</div>')
					.addClass('progress-label')
				)
				.progressbar({
					value: false,
				})
				.hide()
			);

		self.frmelems = $([]).add(self.unInput).add(self.pwInput);

		self._refresh();
		self.element.append(loginPage);
	},

	_refresh: function () {
		var self = this;
		if (self.options.shown) {
			self.widget().show();
		} else {
			self.widget().hide();
		}
	},

	/*
	_setOption: function (key, value) {
		var self = this;
		// _super and _superApply handle keeping the right this-context
		switch (key) {
			case 'shown':
				if (value) {
					self.widget().show();
				} else {
					self.widget().hide();
				}
				break;

		}
		self._superApply(arguments);
	},
	*/
};

});


// vi: fdm=marker

