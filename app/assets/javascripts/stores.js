var Geo = function(options) {

  this.fetchStores = function(position, callback) {
    url = '/stores.json?' + 'latitude=' + position.coords.latitude + '&longitude='
    + position.coords.longitude;

    $.ajax({
      url: url,
      dataType: 'json',
      success: function(resp) {
        callback(resp);
      },
      error: function(resp) {
        throw "Could not fetch stores."
      }
    });
  };
};
