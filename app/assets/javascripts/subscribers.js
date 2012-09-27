(function () {
    $(document).ready(function () {
	$('.invite').on('focus', 'input[type=text]', function () {
	    var avail = $('.invite input[type=text][value=]');
	    if (!avail.length ||
		(avail.length < 2 && !$(this).val()))
		$('<input type="text" name="email[]" /><br />').insertBefore($('.email input[type=submit]'));
	});

	$('.region select').change(function () {
	    var region_level = [ 'provincial', 'city', 'district' ]
	    var next = region_level.indexOf($(this).attr('id')) + 1;
	    if ($(this).val() && next < region_level.length) {
		$.ajax({
		    url: $('input[name=-path]').val() + 'regions/' + $(this).val(),
		    type: 'GET',
		    success: function (data) {
			for (var i = next; i < region_level.length; i++)
			    $('#' + region_level[i]).empty();
			var select = $('#' + region_level[next]);
			select.append('<option></option>');
			for (var k in data) {
			    var option = $('<option></option>');
			    option.val(data[k].id);
			    option.text(data[k].title);
			    select.append(option);
			}
		    }
		});
	    }
	});
    });
})();
