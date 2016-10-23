function Location(attributes){
  this.content = attributes.content;
  this.id = attributes.id;
  this.controlled_by = attributes.controlled_by;
  this.history = attributes.character_locations;
  this.defense = attributes.defense;
}

Location.prototype.constructor = Location;

Location.prototype.renderOwned = function(){
  let content = $('<strong></strong>').text(this.content);
  let defense = $('<strong></strong>').text(this.defense);
  $("#hover_data").append(content, defense);
}

Location.prototype.renderNotOwned = function(){
  let content = $('<strong></strong>').text(this.content);
  $("#hover_data").append(content);
}

Location.prototype.renderHistory = function(){
  debugger;
}


// Location.prototype.takeOver = function (){
//   debugger;
// }

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
        removeForms();
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
    console.log("'That would be intimidating, if you were, well, intimidating.. '");
    if (myTurn()){
      takeOver(gameId, locationId);
      showForms();
    } else {
      $('#turn').html("Please wait for your turn!")
      setTimeout(function(){fetchGame(gameId);}, 5000);
    }
  });
}
