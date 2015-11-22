class Clothing

	def initialize(fanciness)
		@fanciness = fanciness.to_i
		if fanciness >= 4
			@clothes = "http://pngimg.com/upload/suit_PNG8120.png"
			@title   = "Suit up! This is fancy business!"
		elsif fanciness <= 2
			@clothes = "http://images.gearjunkie.com/uploads/2015/09/stormy-kromer-flannel.png"
			@title   = "Lumber up! No one really cares, enjoy your food."
		else
			@clothes ="http://myfashionwants.com/wp-content/uploads/2013/09/7-For-All-Mankind-Womens-Colorblock-Denim-Shirt.png"
			@title   = "Why do you care? Pretty normal place man."
		end
			
	end

	attr_accessor :fanciness,:clothes,:title
end