/// This is the last JS file to be loaded!


function addMenuListeners(){
  $("#navbar a:contains('Home')").bind("click", function(event){
    defaultStopper(event);
    eraseGameList();
    eraseGame();
    removeForms();
    eraseAbout();
    eraseCharacterList();
    console.log("Definitely Maybe You're My Wonderwall")
  });

  $("#navbar a:contains('About')").bind("click", function(event){
    defaultStopper(event);
    console.log("Here we will print the rules! (Not Vanderpump)");
    printRules();
  });

  $('#navbar a[href="/games"]').bind("click", function(event){
    defaultStopper(event);
    console.log("Fetch ALL the games, my demon doggy!")
    fetchGames();
  });

  $('#navbar a[href="/games/new"]').bind("click", function(event){
    defaultStopper(event);
    generateNewForm("games");
  });

  if (loggedIn()){
    $('#navbar a[href="/players/' + playerId + '/characters/new"]').bind("click", function(event){
      defaultStopper(event);
      generateNewForm('players/' + playerId + '/characters');
    });
  }

  $("#navbar a:contains('My Characters')").bind("click", function(event){
    defaultStopper(event);
    fetchMyCharacters();
  });

  $("#shortcut a:contains('Current game')").bind("click", function(event){
    defaultStopper(event);
    fetchGameViaUrl(event.currentTarget.href);
  });

}

$(function(){
  if (loggedIn()){
    showPlayer();
  }
  addMenuListeners();
  console.log("You think this is a game???");
});
