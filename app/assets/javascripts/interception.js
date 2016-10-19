function addMenuListeners(){
  $(".nav a:contains('Home')").bind("click", function(event){
    defaultStopper(event);
    eraseGameList();
    eraseGame();
    removeForms();
    eraseStatusBox();
    console.log("Definitely Maybe You're My Wonderwall")
  });

  $(".nav a:contains('About')").bind("click", function(event){
      defaultStopper(event);
    console.log("Here we will print the rules! (Not Vanderpump)");
    printRules();
  });

  $('.nav a[href="/games"]').bind("click", function(event){
    defaultStopper(event);
    console.log("Fetch ALL the games, my demon doggy!")
    fetchGames();
  });

  $('.nav a[href="/games/new"]').bind("click", function(event){
    defaultStopper(event);
    generateNewForm("games");
  });

  $('.nav a[href="/players/' + playerId + '/characters/new"]').bind("click", function(event){
    defaultStopper(event);
    generateNewForm('players/' + playerId + '/characters');
    console.log("Let's create a new character!!!")
  });

  $(".nav a:contains('My Characters')").bind("click", function(event){
    defaultStopper(event);
    console.log("Here we will show all the characters owned by the current_player")
    fetchMyCharacters();
  });

}

$(function(){
  addMenuListeners();
  console.log("You think this is a game???");
});
