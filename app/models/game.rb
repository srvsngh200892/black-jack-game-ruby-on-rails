class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, :through => :user_games

	after_create do
		self.users << User.dealer
	end

	def dealer
		User.dealer
	end

	def dealer_hand
		user_games.where( :user_id => dealer.id).first
	end

	def is_done?
		self.users.find { |u| u.hand(self).value >= 21 } ? true : false
	end

	def buster
		self.users.find { |u| u.hand(self).value > 21 }
	end

	def nonbuster
		self.users.find { |u| u.hand(self).value <= 21 }
	end

	def twentyone
		self.users.find { |u| u.hand(self).value == 21 }
	end

	def winner
		w = nil
		if self.is_done? then
			if buster then
				w = nonbuster
			elsif twentyone then
				w = twentyone
			end
		end
		w
	end
end
