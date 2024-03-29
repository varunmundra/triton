class DashboardsController < ApplicationController
	def index
		if current_user.role == 'admin'
			@users = User.all
		end
		if current_user.role == 'Manager'
			@projects = Project.where("manager_id = ? ",current_user.id)
		end
	end

	def new_user
		if current_user.role = 'admin'
			@user1= User.new
		end
	end

	def create_new_user
		if current_user.role = 'admin'
			@user1 = User.new
			@user1.first_name = params[:first_name]
			@user1.last_name = params[:last_name]
			@user1.email = params[:email]
			@user1.role = params[:role]
			@user1.password = params[:password]
			@user1.password_confirmation = params[:password_confirmation]
			@user1.save(:validate => false)
			redirect_to show_user_dashboards_path({:id => @user1.id})
		end
	end

	def show_user
		@user = User.find(params[:id])
	end

	def delete_user
	  @deleted_user = User.find(params[:id])
	  @deleted_user.destroy
	  redirect_to dashboards_path
	end

	def edit_user
		@edited_user = User.find(params[:id])
	end


	def update_user
	  
	  if current_user.role = 'admin'
		@edited_user = User.find_by_id(params[:id])	
		@edited_user.first_name = params[:first_name]
		@edited_user.last_name = params[:last_name]
		@edited_user.email = params[:email]
		@edited_user.role = params[:role]
		@edited_user.password = params[:password]
		@edited_user.password_confirmation = params[:password_confirmation]
		@edited_user.save(:validate => false)
		redirect_to show_user_dashboards_path({:id => @edited_user.id})
	   
	   end
	 
	end
end
