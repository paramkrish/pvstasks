// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require ckeditor/init
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .

setTimeout(function() {    $('.alert,.errormesg,.successmesg').fadeOut();}, 3000); // <-- time in milliseconds




//$(function() {
  //              $('#datetimepicker1').datetimepicker( { format : "DD-MMM-YYYY"} );
//});



var addDatePicker = function() {
    // First, get a list of all elements we need to apply this to
    var elements = $('#datetimepicker1');
    
    // Loop through each of them
    elements.each(function(index, elem) {
        // Convert elem into jQuery object
        $elem = $(elem);
        
        // Check if data attribute called "datepicker-attached"
        // If not, then call datepicker on it and set
        // the "datepicker-attached" data attribute to true
        if (!$elem.data('datepicker-attached')) {
            // Attach the datepicker
            $elem.datetimepicker( { format : "DD-MM-YYYY", minDate : "moment" } );
            
            // Set datepicker-attached data-attribute to be true
            $elem.data('datepicker-attached', true);
        }
    });
}

var ckEditor = function()  { 
CKEDITOR.replace( $('.ckeditor').attr('id') ,
    {
        toolbar : 'Basic', /* this does the magic */
        uiColor : '#AFAFAA'
    });

}


var $document = $(document);


$document.on('turbolinks:load', function(event) {
//  console.log("turbolinks:load done");
  addDatePicker();
  //ckEditor();
});



//window.onbeforeunload = function(){
//  return 'Are you sure you want to leave?';
//};