$().ready(function () {
    $('.file_combo input[type=file]').change(function () {
	var file = $(this).val();
	$(this).parents('form').ajaxSubmit({
	    url: $('input[name=-path]').val() + 'resources',
	    data: { _method: 'POST' },
	    success: function (data) {
		if (!data.error) {
		    $('.file_combo input[type=text]').val(file);
		    $('.file_combo input[type=hidden]').val(data.path);
		    $('.file_combo img').attr('src', data.url);
		}
	    }
	});
    });
});
