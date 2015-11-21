class Sale < ActiveRecord::Base
	before_create :populate_guild
	belongs_to :book

	private

	def populate_guild
		self.guid = SecureRandom.uuid()
	end
end

