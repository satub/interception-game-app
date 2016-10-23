/// This is the last JS file to be loaded!


function addMenuListeners(){
  $("a:contains('Home')").bind("click", function(event){
    defaultStopper(event);
    cleanScreen();
    hideLayout();
    console.log("Definitely Maybe You're My Wonderwall")
  });

  $("a:contains('About')").bind("click", function(event){
    defaultStopper(event);
    console.log("Here we will print the rules! (Not Vanderpump)");
    printRules();
  });

  $('a[href="/games"]').bind("click", function(event){
    defaultStopper(event);
    console.log("Fetch ALL the games, my demon doggy!")
    fetchGames();
    showGames();
  });

  $('a[href="/games/new"]').bind("click", function(event){
    defaultStopper(event);
    generateNewForm("games");
    showForms();
  });

  if (loggedIn()){
    $('a[href="/players/' + playerId + '/characters/new"]').bind("click", function(event){
      defaultStopper(event);
      generateNewForm('players/' + playerId + '/characters');
      showForms();
    });
  }

  $("a:contains('My Characters')").bind("click", function(event){
    defaultStopper(event);
    fetchMyCharacters();
    showCharacters();
  });

  $("a:contains('Current game')").bind("click", function(event){
    defaultStopper(event);
    fetchGameViaUrl(event.currentTarget.href);
    showGame();
  });

}

$(function(){
  if (loggedIn()){
    showPlayer();
  }
  hideLayout();
  addMenuListeners();
  console.log("You think this is a game???");
});
