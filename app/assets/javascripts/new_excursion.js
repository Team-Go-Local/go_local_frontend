// autocomplete searchbar
var autocomplete;
function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete(
    document.getElementById('autocomplete'),
    {
      componentRestrictions: {'country': ['US']},
      fields: ['place_id', 'name', 'formatted_address', 'types', 'geometry']
    });
  autocomplete.addListener('place_changed', onPlaceChanged);
}

var place;
function onPlaceChanged() {
  place = autocomplete.getPlace();

  if (!place.geometry) {
    document.getElementById('autocomplete').placeholder = 'Enter a place';
  } else {
    document.getElementById('autocomplete').innerHTML = place.name;
    document.getElementById('title').value = place.name;
    document.getElementById('location').value = place.formatted_address;
    document.getElementById('place_id').value = place.place_id;
    document.getElementById('coordinates').value = place.geometry.location;
    document.getElementById('map').style.display = 'inline-block';
    document.getElementById('map').setAttribute('src', `https://www.google.com/maps/embed/v1/place?key=${mapKey}&q=place_id:${place.place_id}&zoom=12`);
  }
}
