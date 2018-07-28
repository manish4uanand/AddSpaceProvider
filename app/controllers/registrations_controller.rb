class RegistrationsController < Devise::RegistrationsController

	def new
    super
  end

  def create
  	# super
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to slots_path and return
    else
      redirect_to new_user_registration_path
    end
  end

  def update
    super
    @user.update_attribute("name", user_params[:name])
    @user.update_attribute("mobile", user_params[:mobile])
    @user.update_attribute("address", user_params[:address])
    sign_in(@user)
  end


  private

    def user_params
    	params.require(:user).permit(:name, :email, :mobile, :address, :role, :password, :password_confirmation)
    end
end
