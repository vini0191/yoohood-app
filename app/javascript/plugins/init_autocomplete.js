// import places from 'places.js';
// const initAutocomplete = () => {
//   const addressInput = document.getElementById('city_input');
//   if (addressInput) {
//     places({ container: addressInput });
//   }
// };

// export { initAutocomplete };


// app/javascript/components/autocomplete.js
function initAutocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var flatAddress = document.getElementById('city_input');

    if (flatAddress) {
      var autocomplete = new google.maps.places.Autocomplete(flatAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(flatAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { initAutocomplete };
