module Radar
  class RadioShack
    @locations = []

    def self.near(zip = 10012)
      resp = HTTParty.get("http://www.radioshack.com/product/inStoreAvail.jsp", 
      :query => {:productId => 12268262, :zip => zip}, :format => :html)
      doc = Nokogiri::HTML(resp)
      
      doc.css('a').each do |link|
        href = link['href'] || ''
        if href.include?('/map/index.jsp?')
          options = location_href_to_hash(href)
          loc = Store.find(:first, :conditions => options) || 
                Store.create(options)
          @locations << loc
        end
      end
      
      return @locations
    end
    
    def self.location_href_to_hash(href)
      matches = href.scan(/[\?|&][\w]+\=(.*?)(?=&)/).flatten!
      Rails.logger.info matches
      
      return {
        :name => matches[0], 
        :city => matches[2],
        :phone => matches[3],
        :state => matches[4],
        :zip => matches[5],
        :latitude => matches[6],
        :longitude => matches[7],
        :address1 => matches[8],
      }
    end
  end
end
