class Card < ActiveRecord::Base
  belongs_to :user_game

	@@numbers = (2..10).to_a.map { |i| i.to_s }
	@@royalty = [ "jack", "queen", "king" ]
	@@ranks = [ "ace" ] + @@numbers + @@royalty

	def self.ranks
		@@ranks
	end

	def self.values
		Hash[
			[[ "ace", 1 ]] +
			@@numbers.map { |si| [ si, si.to_i ] } +
			@@royalty.map { |royal| [ royal, 10 ] }
		]
	end

	def self.hit
		self.create( :rank => self.ranks[ rand( 12)])
	end

	def value
		self.class.values[self.rank]
	end
end
