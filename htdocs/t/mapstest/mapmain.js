$(document).ready(function () {
	var dbg = $('#debug');

	var dbgmsg = function (msg) {
		dbg.append($('<div></div>').text(msg));
	};

	var retr = function (id, cont) {
		dbgmsg('crumb : ['+id+':'+cont+']');
	};

	window.crumbsMap.init();

	//bs.getCrumb('GBIs9yI729HaQKw', retr);
	/*
	var gotNearby = function (nblist) {
		for (var i in nblist) {
			var nb = nblist[i];
			dbgmsg('Got nearby id ' + nb);

		}
	};

	bs.getNearby(gotNearby);
	*/
});
