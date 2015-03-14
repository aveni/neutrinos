# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  number     :integer
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base

	has_many :matches
	after_destroy :cleanup

	validates :number, presence:true, uniqueness:true
	validates :name, presence:true

	def show_team
		"#{number} #{name}"
	end

	def cleanup
		Match.all.each do|m|
			if m.blue1_id==self.id || m.blue2_id==self.id || m.red1_id==self.id || m.red2_id==self.id
				m.destroy
			end
		end
	end
end
