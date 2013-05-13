$(document).ready(function () {
	var dbg = $('#debug');

	var dbgmsg = function (msg) {
		dbg.append($('<div></div>').text(msg));
	};

	var retr = function (buf) {

		dbgmsg('crumb : ['+buf.id+':'+buf.msg+']');
	};

	var lst = function (data) {
		for (var i in data.list) {
			var c = data.list[i];
			dbgmsg('list : ['+c[0]+':'+c[1]+']');

			window.Crumbs.get(c[0], retr);
		}
	};

	window.Crumbs.list({latitude:1,longitude:1},lst);

/*
	$('#postform').submit(function (e) {
		e.preventDefault();
		Crumbs.put({
			latitude:$('#lat').val(),
			longitude:$('#lon').val(),
		}, $('#msg').val(),
		null,
		null,
		function (d) {
			alert(d.result + ' : ' + d.msg);
		});
	});
*/
});
