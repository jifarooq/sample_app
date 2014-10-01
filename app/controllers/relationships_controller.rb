class RelationshipsController < ApplicationController
	before_filter :signed_in_user

	def create 
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy 
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

end

=begin
Note: on first run, got error uninitialized constant RelationshipsController::Relationships
because I put @user = Relationships instead of @user = Relationship
This code assigns to the model/class, which is spelled 'Relationship'

For future reference when getting these errors, check the names of your models and files!
=end
