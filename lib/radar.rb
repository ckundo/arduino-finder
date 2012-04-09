module Radar
  class RadioShack
    @locations = []

    def self.near(zip = 10012)
      resp = HTTParty.get("http://www.radioshack.com/product/inStoreAvail.jsp", 
      :query => {:productId => 12268262, :zip => zip}, :format => :html)
      doc = Nokogiri::HTML(resp)
      
      doc.css('a').each do |link|
        options = parse_link(link)
        if options
          loc = (Store.find(:first, :conditions => options) || 
                Store.create(options))
          @locations << loc
        end
      end
      
      return @locations
    end
    
    def self.parse_link(link)
      href = link['href']
      if href.include?('/map/index.jsp?')
        params = Hash[*href.scan(/[\?|&](\w+)\=(.*?)(?=&)/).flatten]

        options = {
          :name => params[:storeLoc], 
          :city => params[:city],
          :phone => params[:phone],
          :state => params[:stateCode],
          :zip => params[:postalCode],
          :latitude => params[:latitude],
          :longitude => params[:longitude],
          :address1 => params[:address1],
        }
      end
    end
  end
end
