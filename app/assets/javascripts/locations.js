function fetchLocation(locationId){
  console.log("'That would be intimidating, if you were, well, intimidating.. '");
}

function addLocationTakeOverListeners(){
  $('div.location').bind("click", function(event){
    event.preventDefault();
    event.stopPropagation();
    var locationId = $(this).attr('data-locationid');
    fetchLocation(locationId);
  });
}


/// Hopefully can be added without revealing too much information :P
function addLocationHoverListeners(){

}
