class RestaurantsController < ApplicationController
	
	def index
		if params[:q].present?
			@restaurants = Restaurant.search(params[:q])
		end

		respond_to do |format|
			format.html
		end
	end
end
