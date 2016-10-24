function Location(attributes){
  this.content = attributes.content;
  this.id = attributes.id;
  this.controlled_by = attributes.controlled_by;
  this.history = attributes.character_locations;
  this.defense = attributes.defense;
}

Location.prototype.renderOwned = function(){
  let content = $('<strong></strong>').text(this.content);
  let defense = $('<strong></strong>').text(' Defense: ' + this.defense);
  $("#hover_data").append(content, defense);
}

Location.prototype.renderNotOwned = function(){
  let content = $('<strong></strong>').text(this.content);
  $("#hover_data").append(content);
}

Location.prototype.renderHistory = function(){
  var history = this.history;
  var locationHistory = 'Previous messages: <ul>';
  for (var i = 0; i < history.length; i++){
    locationHistory += '<li>' + history[i].message + ' by ' + history[i].character.name;

    if (history[i].success){
      locationHistory += "; Attempt success with"
    } else {
      locationHistory += ": Attempt failure with"
    }
    locationHistory += history[i].troops_sent + ' troops sent.</li>';
  }
  locationHistory  += '</ul>';
  $('#history').html(locationHistory);
}


function takeOver(gameId, locationId){
  removeForms();
  var resourceUrl = '/games/' + gameId + '/locations/' + locationId + '/edit';
  $.get(resourceUrl).done(function(response){
    $('#forms').html(response);
    $('#forms form').on("submit", function(event){
      event.preventDefault();
      var $form = $(this);
      var formUrl = $form.attr("action");
      var params = $form.serialize();


      $.ajax({
        url: formUrl,
        method: 'PATCH',
        data: params
      }).done(function (response){
        var game = new Game(response.game);
        game.renderGame();
        hideForms();
      }).fail(function (error){
        debugger;
      });
    });
  });
  showTurn();
}

function fetchLocation(gameId, locationId){
  var locationUrl = "/games/" + gameId + "/locations/" + locationId;
  $.get(locationUrl).done(function(response){
    var loc = new Location(response.location);
    if (loc.controlled_by === playerId){
      loc.renderOwned();
    } else {
      loc.renderNotOwned();
    }
  });
}

function addLocationTakeOverListeners(gameId){
  $('div.location').bind("click", function(event){
    defaultStopper(event);
    var locationId = $(this).attr('data-locationid');
    var controller = this.innerHTML;

    var locationUrl = "/games/" + gameId + "/locations/" + locationId;
    $.get(locationUrl).done(function(response){
      var loc = new Location(response.location);
      loc.renderHistory();
      showHistory();
    });
    if (myTurn() && controller != playerId){
      showForms();
      takeOver(gameId, locationId);
    } else if (myTurn() && controller == playerId){
      $('#turn').html("You already own this location!")
      setTimeout(function(){fetchGame(gameId);}, 3000);
    } else {
      $('#turn').html("Please wait for your turn!")
      setTimeout(function(){fetchGame(gameId);}, 3000);
    }
  });
}
