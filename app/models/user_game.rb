class UserGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
	has_many	 :cards

	after_create do
	 	cards << Card.hit
		cards << Card.hit
	end

	def value
		non_aces = cards.find_all { |c| c.rank != "ace" }
		aces = cards.find_all { |c| c.rank == "ace" }
		non_aces_value = non_aces.reduce(0) { |m,c| m + c.value }

		retval, boundary = non_aces_value, 21 - non_aces_value
		if !aces.empty? then
			retval += aces.count
			if aces.count <= boundary then
				retval += (11 <= boundary) ? 10 : 0
			end
		end

		retval
	end

	def busted?
		value > 21
	end
end
