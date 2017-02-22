class UsersController < ApplicationController
  def index
    @users = User.all
		@user = User.find_by_id(session[:user_id])
    return redirect_to login_path if @user.blank?
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html {
					redirect_to login_path,
						notice: 'Attention! your registration was successful.'
				}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


	def logout
		session[:user_id] = nil
		session[:game_id] = nil
		redirect_to login_path
	end

  def stats
    @user = User.find_by_id(session[:user_id])
    return redirect_to login_path if @user.blank?
    @games = UserGame.includes(:game).where(user_id:session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit!()
  end
end
