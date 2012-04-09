//= require stores

describe('Store', function() {
  it("has location objects", function() {
    store = new Store({zip: '91105'});
    store.fetchLocations(function(locations) {
      expect(locations.length).toBeGreaterThan(0);
    });
 });
})
