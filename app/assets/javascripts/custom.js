// JavaScript Document

// Dropdown on Mouseover
$('document').ready(function(){

	<!-- Accrodian -->	
	var $acdata = $('.accrodian-data'),
		$acclick = $('.accrodian-trigger');

	$acdata.hide();
	$acclick.first().addClass('active').next().show();	
	
	$acclick.on('click', function(e) {
		if( $(this).next().is(':hidden') ) {
			$acclick.removeClass('active').next().slideUp(300);
			$(this).toggleClass('active').next().slideDown(300);
		}
		e.preventDefault();
	});
		
		
	<!-- Toggle -->			
	$('.togglehandle').click(function()
	{
		$(this).toggleClass('active')
		$(this).next('.toggledata').slideToggle()
	});
	
	
	// Dropdowns
	$('.dropdown').hover(
		function(){$(this).addClass('open')			
		},
		function(){			
			$(this).removeClass('open')
		}
		);
		
	// Product thumbnails
	$('.thumbnail').each(function()
	{
		
		$(this).hover(
		function(){
			//$(this).children('a').children('img').fadeOut()
			$(this).children('.shortlinks').fadeIn()
		},
		function(){	
			//$(this).children('a').children('img').fadeIn()		
			$(this).children('.shortlinks').fadeOut()
		}
		);
		
	});
	
	// Checkout steps
	$('.checkoutsteptitle').addClass('down').next('.checkoutstep').fadeIn()
	$('.checkoutsteptitle').live('click', function()
	{		
	$("select, input:checkbox, input:radio, input:file").css('display', 'blcok');	
		$(this).toggleClass('down').next('.checkoutstep').slideToggle()
	});
		
	// Category Menu mobile
	 $("<select />").appendTo("nav.subnav");
      
      // Create default option "Go to..."
      $("<option />", {
         "selected": "selected",
         "value"   : "",
         "text"    : "Go to..."
      }).appendTo("nav.subnav select");
      
      // Populate dropdown with menu items
      $("nav.subnav a").each(function() {
       var el = $(this);
       $("<option />", {
           "value"   : el.attr("href"),
           "text"    : el.text()
       }).appendTo("nav.subnav select");
      });
      
	   // To make dropdown actually work
	   // To make more unobtrusive: http://css-tricks.com/4064-unobtrusive-page-changer/
      $("nav.subnav select").change(function() {
        window.location = $(this).find("option:selected").val();
      });
	  
	// Product Thumb
	$('.mainimage li #wrap').hide()
	$('.mainimage li #wrap').eq(0).fadeIn()
	$('ul.mainimage li.producthtumb').click(function(){
		var thumbindex = $(this).index()		
		$('.mainimage li #wrap').fadeOut(0)
		$('.mainimage li #wrap').eq(thumbindex).fadeIn()
		 $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
	})
			
	// List & Grid View
	$('#list').click(function()
	{	$(this).addClass ('btn-info').children('i').addClass('icon-white')
		$('.grid').fadeOut()
		$('.mboh').fadeOut()
		$('.list').fadeIn('fast')
		$('#grid').removeClass ('btn-info').children('i').removeClass('icon-white')
	});
	$('#grid').click(function()
	{	$(this).addClass ('btn-info').children('i').addClass('icon-white')
		$('.list').fadeOut()
		$('.grid').fadeIn("fast")
		$('.mboh').fadeIn("fast")
		$('#list').removeClass ('btn-info').children('i').removeClass('icon-white')
	});
	
	// Prdouctpagetab 
	$('#myTab a:first').tab('show')
		$('#myTab a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	});
	
	// alert close 
	$('.clostalert').click(function()
	{
	$(this).parent('.alert').fadeOut ()
	});	

})

	// Contact Form

	$(document).ready(function() {	
		$(".contactform").validate({
	   submitHandler: function(form) {
		   var name = $("input#name").val();
		   var email = $("input#email").val();
		   var url = $("input#url").val();
		   var message = $("textarea#message").val();
		   
		   var dataString = 'name='+ name + '&email=' + email + '&url=' + url+'&message='+message;
		  $.ajax({
		  type: "POST",
		  url: "email.php",
		  data: dataString,
		  success: function() {
			  $('#contactmsg').remove();
			  $('.contactform').prepend("<div id='contactmsg' class='successmsg'>Form submitted successfully!</div>");
			   $('#contactmsg').delay(1500).fadeOut(500);
			  $('#submit_id').attr('disabled','disabled');
			  }
		 	});   
	   return false;
	  	}
		});
	});

<!-- Scroll top -->		  
$(window).scroll(function () {
		if ($(this).scrollTop() > 50) {
			$('#gotop').fadeIn(500);
		} else {
			$('#gotop').fadeOut(500);
		}
	});


/* [ ---- Gebo Admin Panel - dashboard ---- ] */

	$(document).ready(function() {
		//* sortable/searchable list
		gebo_flist.init();
		gebo_fgrid.init();
		var lastWindowHeight = $(window).height();
		var lastWindowWidth = $(window).width();
		$(window).on("debouncedresize",function() {
			if($(window).height()!=lastWindowHeight || $(window).width()!=lastWindowWidth){
				lastWindowHeight = $(window).height();
				lastWindowWidth = $(window).width();
				//* rebuild calendar
				$('#calendar').fullCalendar('render');
			}
		});
	});

	//* filterable list
	gebo_flist = {
		init: function(){
						
			var pagingOptions = {};
			var options = {
				valueNames: [ 'caption' ],
				page: 3,
				plugins: [
					[ 'paging', {
						pagingClass	: "bottomPaging",
						innerWindow	: 1,
						left		: 1,
						right		: 1
					} ]
				]
			};
			var productList = new List('product-list', options);
		}
	};

	gebo_fgrid = {
		init: function(){
			
			var pagingOptions = {};
			var options = {
				valueNames: [ 'puss' ],
				page: 9,
				plugins: [
					[ 'paging', {
						pagingClass	: "bottomPaging1",
						innerWindow	: 1,
						left		: 1,
						right		: 1
					} ]
				]
			};
			var productGrid = new List('product-grid', options);
		}
	};
	

