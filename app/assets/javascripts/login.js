(function () {
    var R = (function () {
	function AsyncCall() {
	    var pendings = [];
	    var cb = null;

	    this.success = function (args) {
		if (args instanceof Function) {
		    var each;
		    while (each = pendings.shift())
			args.apply(null, each)
		    cb = args;
		}
		else if (cb != null)
		    cb.apply(null, args);
		else
		    pendings.push(args)
	    }

	    return this;
	}

	function serve(path, data, method) {
	    var acall = new AsyncCall();
	    $.ajax({
		url: $('input[name=-path]').val().replace(/\/$/, '') + path,
		type: method || 'POST',
		data: data,
		success: function () {
		    acall.success(arguments);
		}
	    });

	    return acall;
	}

	return {
	    check:	function (email) {
		return serve('/check', { subscriber: { email: email } });
	    }
	};
    })();

    $(document).ready(function () {
	$('.sign_up #new_subscriber input[name=commit]').click(function () {
	    var email = $('#new_subscriber #subscriber_email').val();
	    R.check(email).success(function (data) {
		if (data['new']) {
		    if ($('.sign_up #new_subscriber input[type=password]').val())
			$('.sign_up #new_subscriber').submit();
		    else
			$('.sign_up #new_subscriber .password').slideDown('slow', function () {
			    $('.sign_up #new_subscriber').addClass('stage2');
			});
		}
		else
		    document.location = $('input[name=-sign_in]').val() + '?email=' + encodeURI(email);
	    });
	    return false;
	});
    });
})();
