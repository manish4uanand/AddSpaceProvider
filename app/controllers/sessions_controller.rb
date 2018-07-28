class SessionsController < Devise::SessionsController

	def new
    super
  end

  def create  	
  	if params[:user][:role].present?
	  	# super
	  	@user = User.find_by_email params[:user][:email]
	  	sign_in(@user)
	    if current_user.role == params[:user][:role].to_i
	    	redirect_to slots_path and return
	    else
	    	redirect_to destroy_user_session_path
	    end
	   else
	   	flash[:alert] = "Please provide Login type"
	   	redirect_to root_path and return
	   end
  end

end
