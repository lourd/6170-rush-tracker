// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can no longer use CoffeeScript in this file: http://coffeescript.org/

var ready = function() {
};

var slideShow = function() {
  var currentID = 0;

  alert("Press ESC to return to main site. Press F11 to view FullScreen!");

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
  var pictureURL = rushee.picture+"?timestamp=" + new Date().getTime();
  pictureURL = pictureURL.replace("original","medium");
  console.log(pictureURL);
  $("#slideImage").attr("src", pictureURL);

  $("#slideName").html(rushee.firstname+" "+rushee.lastname);
  updatePrimaryContactName(rushee.primary_contact_id);
  $("#slideEmail").html(rushee.email);
  $("#slidePhone").html(rushee.cellphone);
  $("#slidefaceBook").html(rushee.facebook_url);
  $("#slideDorm").html(rushee.dorm);
  $("#slideHometown").html(rushee.hometown);
  $("#slideSports").html(rushee.sports);
  $("#slideCompetingFrats").html(rushee.frats_rushing);
  $("#slideActionStatus").html(rushee.action_status);
  $("#slideBidStatus").html(rushee.bid_status);
};

var updatePrimaryContactName = function(id) {
  $.ajax({
      url: "/accounts/detail/" + id,
      success: function(data) { 
         $("#slidePrimary").html(data.firstname+" "+data.lastname);
      },
      dataType: "json"
    });
}

//Listeners for Normal Page Loads and Link_Tos
$(document).ready(ready);
$(document).on('page:load', ready);
