/// This is the last JS file to be loaded!

function addMenuListeners(){
  $("a:contains('Clear')").bind("click", function(event){
    defaultStopper(event);
    cleanScreen();
    hideLayout();
  });

  $("a:contains('About')").bind("click", function(event){
    defaultStopper(event);
    printRules();
  });

  $('a[href="/games"]').bind("click", function(event){
    defaultStopper(event);
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

function addDynamicEventListeners(){

  // Listen to game list
  $('#main').on("click", 'li[data-gameid]', function(event){
    defaultStopper(event);
    var gameId = $(this).attr('data-gameid');
    fetchGame(gameId);
    showGame();
    hideAbout();
  });

  // Listen to game Launch link
  $('body').on("click", '#turn div:contains("Launch Game!")', function (event){
    defaultStopper(event);
    let startUrl = $(this).attr("data-starturl")
    launchGame(startUrl);
  });

  // Listen to game Join link
  $('body').on("click", '#turn div:contains("Join This Game")', function (event){
      defaultStopper(event);
      let joinUrl = $(this).attr("data-joinurl")
      joinGame(joinUrl);
    });

 // Listen to current game shortcut link
 $('body').on("click", '#shortcut a:contains("Current game")', function(event){
   defaultStopper(event);
   fetchGameViaUrl(event.currentTarget.href);
 });


 // Listen to mouseover events on the map
 $('body').on("mouseenter", 'div.location', function(event){

  let locationId = $(this).attr('data-locationid');
  let gameId = $("a:contains('Current game')")[0].href.match(/\d+$/)[0];
  defaultStopper(event);
  fetchLocation(gameId, locationId);
  $("#hover_data").css( {position:"absolute", top:event.pageY, left: event.pageX});
});

 $('body').on("mouseleave", 'div.location', function(event){
     defaultStopper(event);
     $("#hover_data").html('');
   });

}


$(function(){
  if (loggedIn()){
    showPlayer();
  }
  hideLayout();
  addMenuListeners();
  addDynamicEventListeners();
});
