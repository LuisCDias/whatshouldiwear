class Restaurant

	def self.search(q)
		conn = Faraday.new(:url => 'https://developers.zomato.com') do |faraday|
		  faraday.request  :url_encoded             # form-encode POST params
		  faraday.response :logger                  # log requests to STDOUT
		  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
		end
		#raise "https://developers.zomato.com/api/v2.1/search?q=#{URI.escape(q)}"
		response = conn.get "/api/v2.1/search?q=#{URI.escape(q)}" do |req|    # GET http://sushi.com/nigiri/sake.json
			req.headers['Content-Type'] = 'application/json'
			req.headers['user_key'] = 'd4b925d03141f6f9fbff52d0e57a49c7'
		end		
		Restaurant.parse(response.body)
	end

	def self.parse(response)
		begin
			unparsed_restaurants = JSON.parse(response.to_s)
		rescue Exception => e
			return []
		end		
		
		parsed_restaurants = []
		unparsed_restaurants["restaurants"].each do |unparsed_restaurant|
			unparsed_restaurant = unparsed_restaurant["restaurant"]
			restaurant = Restaurant.new(unparsed_restaurant)
			parsed_restaurants << restaurant
		end
		parsed_restaurants
	end

	def initialize(unparsed_restaurant)
		@id = unparsed_restaurant["id"]
		@name = unparsed_restaurant["name"]
		@url = unparsed_restaurant["url"]
		@city = unparsed_restaurant["location"]["city"]
		@thumb = unparsed_restaurant["thumb"]
		@rating = unparsed_restaurant["user_rating"]["aggregate_rating"]
		@avg_cost_for_two = unparsed_restaurant["average_cost_for_two"]
		@price_range = unparsed_restaurant["price_range"]
		@clothing = Clothing.new(@price_range)
	end

	attr_accessor :id,:name,:url,:city,:thumb,:rating,:avg_cost_for_two,:price_range,:clothing
end