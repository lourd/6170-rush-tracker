// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can no longer use CoffeeScript in this file: http://coffeescript.org/

var slideShow = function() {
  var currentID = 0;
  
  //On escape press, redirect to Rushees Index
  $(document).keyup(function(e) {
    //Handle Escape Key Press  
    if (e.keyCode == 27) { 
      window.location.href = "/rushees";
    }
  });

  //Function to load a brother with the requested ID
  var loadBrother = function(requestedID) {
    $.ajax({
      url: "/presentation",
      success: function(data) { 
        var rusheeCount = data.length;
        if (requestedID >= rusheeCount) {
          //alert("End of the show");
        }
        else if (requestedID < 0) {
          //alert("No previous slides");
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

  //On "Back" Press Load the Previous Slide
  $("#lastSlide").click(function(e) {
    e.preventDefault();
    loadBrother(currentID - 1);
  });

  //On "Next" Press Load the Next Slide
  $("#nextSlide").click(function(e) {
    e.preventDefault();    
    loadBrother(currentID + 1);
  });

  //Go in the Slide Direction of the Key Press
  $(document).keydown(function(e){
    if (e.keyCode == 37 || e.keyCode == 38) { 
      e.preventDefault();
      loadBrother(currentID - 1);
    }
    else if (e.keyCode == 39 || e.keyCode == 40) { 
      e.preventDefault();
      loadBrother(currentID + 1);
    }
  });
  
};

//Function to Load All the Information on a Slide (Given a rushee json)
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

//Ajax Call to get Primary Contact's name from Rails server
var updatePrimaryContactName = function(id) {
  $.ajax({
      url: "/accounts/detail/" + id,
      success: function(data) { 
         $("#slidePrimary").html(data.firstname+" "+data.lastname);
      },
      dataType: "json"
    });
};


//Functions to Respond to Icon Presses
var clickVote = function(id, target) {
  $.ajax({
    url: "/rushees/" + id + "/getApproval",
    method: "get",
    success: function(data) {
      if (data[0].vote) {
        removeVote(id);
        target.removeClass("btn-true"); 
      }
      else {
        upVote(id);
        target.addClass("btn-true");  
      }
    }
  });
};

var clickMeet = function(id, target) {
  $.ajax({
    url: "/rushees/" + id + "/getApproval",
    method: "get",
    success: function(data) {
      if (data[0].met) {
        unmeet(id);
        target.removeClass("btn-true"); 
      }
      else {
        meet(id);
        target.addClass("btn-true"); 
      }
    }
  });
};


//Send Ajax requests for specific functions
var upVote = function(id) {
  $.ajax({
      url: "/rushees/" + id +"/upVote",
      method: "post",
      success: function(data) {}
  });
};

var removeVote = function(id) {
  $.ajax({
      url: "/rushees/" + id +"/removeVote",
      method: "post",
      success: function(data) {}
  });
};

var meet = function(id) {
  $.ajax({
      url: "/rushees/" + id +"/meet",
      method: "post",
      success: function(data) {}
  });
};

var unmeet = function(id) {
  $.ajax({
      url: "/rushees/" + id +"/unmeet",
      method: "post",
      success: function(data) {}
  });
};

var getApprovalStatus = function(id) {
  $.ajax({
    url: "/rushees/" + id + "/getApproval",
    method: "get",
    success: function(data) { console.log(data); }
  });
}


//On Page Ready, Add Click Handlers for Rushee Index
var ready = function() {
  $(".fa-check").click(function(e){
    var id = $(this).attr("data-rushee-id");
    clickMeet(id, $(this));
  });

  $(".fa-arrow-up").click(function(e){
    var id = $(this).attr("data-rushee-id");
    clickVote(id, $(this));
  });

};

//Listeners for Normal Page Loads and Link_Tos
$(document).on('page:load', ready);
$(document).ready(ready);
