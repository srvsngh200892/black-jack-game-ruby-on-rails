class GamesController < ApplicationController
	def setup
		@user = User.find_by_id(session[:user_id])
    return redirect_to login_path if @user.blank?
		@game = Game.create
		@game.users << @user
		session[:game_id] = @game.id

		redirect_to :action => "play"
	end

	def play
		@user = User.find_by_id(session[:user_id])
		@game = Game.find_by_id( session[:game_id])
    if @user.blank? or @game.blank?
      redirect_to login_path
    end
	end

	def pull
		@user = User.find_by_id(session[:user_id])
		@game = Game.find_by_id( session[:game_id])
    return redirect_to login_path if @user.blank? or @game.blank?
		@user.hit_me(@game)

		dealer = @game.dealer
		if dealer.dealer_strategy(@game) then
			dealer.hit_me(@game)
		end

		redirect_to :action => "play"
	end

	def skip
		@user = User.find_by_id(session[:user_id])
		@game = Game.find_by_id( session[:game_id])
    return redirect_to login_path if @user.blank? or @game.blank?
		dealer = @game.dealer
		if dealer.dealer_strategy(@game) then
			dealer.hit_me(@game)
		end

		redirect_to :action => "play"
	end
end
