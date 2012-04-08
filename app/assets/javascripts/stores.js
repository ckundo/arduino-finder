$.ajax({
    url: '/stores.json',
    dataType: 'json',
    success: function(resp) {
      mapper(resp);
    },
    error: function(resp) {
      console.log('failed to get locations');
    }
});

var mapper = function(locations) {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: new google.maps.LatLng(locations[0].latitude, locations[0].longitude),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var infowindow = new google.maps.InfoWindow();

  var marker, i;

  for (i = 0; i < locations.length; i++) {  
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(locations[i].latitude, locations[i].longitude),
      map: map
    });

    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        infowindow.setContent("<p>" + locations[i].name + "</p>" + locations[i].phone);
        infowindow.open(map, marker);
      }
    })(marker, i));
  }
};
