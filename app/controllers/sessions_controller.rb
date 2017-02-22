class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    password_ok = user ? (user.password == params[:session][:password]) : false
    if user &&  password_ok
      respond_to do |format|
        session[:user_id] = user.id
        format.html { redirect_to setup_games_path  }
      end
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
end
