module Radar
  class Shack
    @base_uri = 'http://www.radioshack.com'
    
    def self.scan(zip = 10012, product_id = 12268262)
      
      query = {:productId => product_id, :zip => zip}
      resp = HTTParty.get("#{@base_uri}/product/inStoreAvail.jsp", :query => query, :format => :html)
      doc = Nokogiri::HTML(resp)
      
      locations = []
      doc.css('a').each do |link|
        href = link['href'] || ''
        if href.include?('/map/index.jsp?')
          name = href.match(/locName=.*&/)[0].split('=')[1].split('&')[0]
          latitude = href.match(/latitude=.*&/)[0].split('=')[1].split('&')[0]
          longitude = href.match(/longitude=.*&/)[0].split('=')[1].split('&')[0]
          address1 = href.match(/address1=.*&/)[0].split('=')[1].split('&')[0]
          city = href.match(/city=.*&/)[0].split('=')[1].split('&')[0]
          zip = href.match(/postalCode=.*&/)[0].split('=')[1].split('&')[0]
          state = href.match(/stateCode=.*&/)[0].split('=')[1].split('&')[0]
          phone = href.match(/phone=.*&/)[0].split('=')[1].split('&')[0]
          
          
          loc = Store.find_by_name(name) || Store.create(:name => name, :latitude => latitude, :longitude => longitude, :address1 => address1,
                 :city => city, :zip => zip, :state => state, :phone => phone)
          locations << loc
        end
      end

      return locations
    end
  end
end
