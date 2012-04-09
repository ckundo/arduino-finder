var Store = function(options) {
  var url = '/stores.json';
  var first = true;

  for(var key in options) {
    var delimeter = first ? '?' : '&';
    url += delimeter;
    url += key + "=" + options[key];
    first = false;
  }
  
  this.fetchLocations = function(callback) {
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
