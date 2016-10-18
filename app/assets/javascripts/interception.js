function addMenuListeners(){
  $(".nav a:contains('Home')").bind("click", function(event){
    event.preventDefault();
    event.stopPropagation();
    console.log("Definitely Maybe You're My Wonderwall")
  });

  $(".nav a:contains('About')").bind("click", function(event){
    event.preventDefault();
    event.stopPropagation();
    console.log("Here we will print the rules! (Not Vanderpump)");
    printRules();
  });

  $('.nav a[href="/games"]').bind("click", function(event){
    event.preventDefault();
    event.stopPropagation();
    console.log("Fetch ALL the games, my demon doggy!")
    fetchGames();
  });

  $('.nav a[href="/games/new"]').bind("click", function(event){
    event.preventDefault();
    event.stopPropagation();
    console.log("We will probably get rid of this menu link and instead produce a form in the games page instead for creating a new game :D");
    generateNewGameForm();
  });

  $('.nav a[href="/mygames"]').bind("click", function(event){
    event.preventDefault();
    event.stopPropagation();
    console.log("Here we will show all the games owned by the current_player")
  });

  $(".nav a:contains('My Characters')").bind("click", function(event){
    event.preventDefault();
    event.stopPropagation();
    console.log("Here we will show all the characters owned by the current_player")
  });

}



$(function(){
  addMenuListeners();
  console.log("You think this is a game???");
});
