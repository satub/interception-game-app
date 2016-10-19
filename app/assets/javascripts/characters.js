function Character(attributes)  {
  this.id = attributes.id;
  this.name = attributes.name;
  this.personality = attributes.personality;
  this.image = attributes.image_link;
  this.ownerId = attributes.player.id;
  this.ownerAlias = attributes.player.alias;
  this.level = attributes.level;
}

Character.prototype.constructor = Character;

Character.prototype.renderChar = function(){
  let div = $('<div data-characterId="' + this.id + '"></div>');
  let img = $('<img />',
             { src: this.image,
               width: 250
             });
  let personality = $('<p></p>').text("Personality: " + this.personality);
  let name = $('<p></p>').html('<strong>' + this.name + '</strong>');
  div.append(name, img, personality);
  $("#characters").append(div);
}

function fetchMyCharacters(){
  eraseCharacterList();
  var charsUrl = "/players/" + playerId + "/characters";
  $.get(charsUrl).done(function(response){
    var chars = response.characters;
    for (var i = 0; i < chars.length; i++){
      var char = new Character(chars[i]);
      char.renderChar();
    }
  });
}

function createNewCharacter(){

}
