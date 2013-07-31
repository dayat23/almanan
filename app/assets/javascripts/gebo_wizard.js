/* [ ---- Gebo Admin Panel - wizard ---- ] */

	$(document).ready(function() {
		//* simple wizard
		gebo_wizard.simple();
		//* wizard with validation
		gebo_wizard.validation();
		//* add step numbers to titles
		gebo_wizard.steps_nb();
	});

	gebo_wizard = {
		simple: function(){
			$('#simple_wizard').stepy({
				titleClick	: true,
				nextLabel:      'Next <i class="icon-chevron-right icon-white"></i>',
				backLabel:      '<i class="icon-chevron-left"></i> Back'
			});
		},
		validation: function(){
			$('#validate_wizard').stepy({
				nextLabel:      'Lanjut <i class="icon-chevron-right icon-white"></i>',
				backLabel:      '<i class="icon-chevron-left"></i> Kembali',
				block		: true,
				errorImage	: true,
				titleClick	: true,
				validate	: true
			});
			stepy_validation = $('#validate_wizard').validate({
				onfocusout: false,
				errorPlacement: function(error, element) {
					error.appendTo( element.closest("div.controls") );
				},
				highlight: function(element) {
					$(element).closest("div.control-group").addClass("error f_error");
					var thisStep = $(element).closest('form').prev('ul').find('.current-step');
					thisStep.addClass('error-image');
				},
				unhighlight: function(element) {
					$(element).closest("div.control-group").removeClass("error f_error");
					if(!$(element).closest('form').find('div.error').length) {
						var thisStep = $(element).closest('form').prev('ul').find('.current-step');
						thisStep.removeClass('error-image');
					};
				},
				rules: {
					'v_username'	: {
						required	: true,
						minlength	: 6
					},
					'v_firstname'	: 'required',
					'v_lastname'	: 'required',
					'v_email'		: {
						email 		: true,
						required	: true
					},
					'v_newsletter'	: 'required',
					'v_phone'		: {
						required	: true,
						number 		: true
					},
					'v_password'	: {
						required	: true,
						minlength	: 6
					},
					'city[city_id]'	: 'required',
					'v_street'		: 'required',
					'v_city'		: 'required',
					'state[state_id]': 'required',
					'prov[state_id]': 'required',
					'order[destination_id]'	: 'required',
					'destination[price]'	: {
						required	: true
					},
					'v_state'		: 'required'
				}, messages: {
					'v_phone'		: { required:  'Telepon tidak boleh kosong!' },
					'v_username'	: { required:  'Username tidak boleh kosong!' },
					'v_firstname'	: { required:  'Nama pertama tidak boleh kosong!' },
					'v_lastname'	: { required:  'Nama terakhir tidak boleh kosong!' },
					'v_email'		: { 
						email	:  'Invalid e-mail!',
						required:  'Email tidak boleh kosong!'
					},
					'v_newsletter'	: { required:  'Newsletter tidak boleh kosong!' },
					'v_password'	: { required:  'Password tidak boleh kosong!' },
					'v_city'		: { required:  'Kota tidak boleh kosong!' },
					'state[state_id]': { required:  'Provinsi tujuan tidak boleh kosong!' },
					'prov[state_id]': { required:  'Provinsi tidak boleh kosong!' },
					'order[destination_id]'	: { required:  'Kota tujuan tidak boleh kosong!' },
					'city[city_id]'	: { required:  'Kota tidak boleh kosong!' },
					'v_street'		: { required:  'Alamat tidak boleh kosong!' },
					'v_state'		: { required:  'Provinsi tidak boleh kosong!' }
				},
				ignore				: ':hidden'
			});
		},
		//* add numbers to step titles
		steps_nb: function(){
			$('.stepy-titles').each(function(){
				$(this).children('li').each(function(index){
					var myIndex = index + 1
					$(this).append('<span class="stepNb">'+myIndex+'</span>');
				})
			})
		}
	};