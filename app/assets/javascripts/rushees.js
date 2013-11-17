// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can no longer use CoffeeScript in this file: http://coffeescript.org/

var ready = function() {
  $(document).keyup(function(e) {
    //Handle Escape Key Press  
    if (e.keyCode == 27) { 
      alert("Peanut butter jelly time");
    }
  });

  $("#lastSlide").click(function(e) {
    alert("Back!");
  });
  
  $("#nextSlide").click(function(e) {
    alert("Next!");
  });

  var slideShow = function() {
    var currentID = ;  
  };
};

//Listeners for Normal Page Loads and Link_Tos
$(document).ready(ready);
$(document).on('page:load', ready);


  /*
   $.ajax({
            url: requestUrl,
            success: function(data) { $('#fill').html(data["content"].replace(/\r\n|\r|\n/g,"<br />")); },
            dataType: "json"
          });
  */
