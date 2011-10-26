class LocationsController < ApplicationController

    def show
		@traveling_party = TravelingParty.find_by_id(session[:party])
	end
	
	def move
		f = params[:traveling_party]
	
		@traveling_party = TravelingParty.find(f["id"])
		@traveling_party.speed = f["speed"].to_i
		@traveling_party.ration = f["ration"].to_i
		@traveling_party.position += @traveling_party.speed
		
		food_eaten = @traveling_party.ration * @traveling_party.people
		Item.where({:trader_id => @traveling_party.id, :type => "Food"}).limit(food_eaten).destroy_all()
		
		if @traveling_party.save()
			flash[:notice] = "Successfully updated traveling party."
            redirect_to '/play/'
        else
            flash[:error] = "Transaction could not be completed."
            redirect_to '/play/'
        end
	end

end