// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can no longer use CoffeeScript in this file: http://coffeescript.org/

var ready = function() {
};

var slideShow = function() {
  var currentID = 0;

  $(document).keyup(function(e) {
    //Handle Escape Key Press  
    if (e.keyCode == 27) { 
      window.location.href = "/rushees";
    }
  });

  var loadBrother = function(requestedID) {
    $.ajax({
      url: "/presentation",
      success: function(data) { 
        var rusheeCount = data.length;
        if (requestedID >= rusheeCount) {
          alert("End of the show");
        }
        else if (requestedID < 0) {
          alert("No previous slides");
        }      
        else {
          var rushee = data[requestedID];
          updatePage(rushee, requestedID);
          currentID = requestedID;
        }
      },
      dataType: "json"
    });
  };

  $("#lastSlide").click(function(e) {
    e.preventDefault();
    loadBrother(currentID - 1);
  });
  
  $("#nextSlide").click(function(e) {
    e.preventDefault();    
    loadBrother(currentID + 1);
  });
};

var updatePage = function(rushee, requestedID) {
  $("#informationCell").attr("data-id", requestedID);
  $("#informationCell").attr("data-rails-id", rushee.id);

  $("#slideName").html(rushee.firstname+" "+rushee.lastname);
  $("#slideEmail").html(rushee.email);
  $("#slidePrimary").html(rushee.primary_contact_id);
  $("#slidePhone").html(rushee.cellphone);
  $("#slidefaceBook").html(rushee.facebook_url);
  $("#slideDorm").html(rushee.dorm);
  $("#slideHometown").html(rushee.hometown);
  $("#slideSports").html(rushee.sports);
  $("#slideCompetingFrats").html(rushee.frats_rushing);
  $("#slideBidStatus").html(rushee.bid_status);
};

//Listeners for Normal Page Loads and Link_Tos
$(document).ready(ready);
$(document).on('page:load', ready);
