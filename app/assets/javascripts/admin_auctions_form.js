$(function () {
	$('#fileupload').fileupload({
		dataType: 'json',
		done: function (e, data) {
			$.each(data.result, function (index, file) {
				console.log(file);
				//$('<p/>').text(file.name).appendTo(document.body);
			});
		}
	});
});