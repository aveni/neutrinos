# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  number     :integer
#  name       :string
#  high_score :integer
#  avg_score  :float
#  win_perc   :float
#  avg_cont   :float
#  st_dev     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base

	has_many :matches
	has_and_belongs_to_many :events
	after_destroy :cleanup

	validates :number, presence:true, uniqueness:true, :numericality => {:greater_than => 0}
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
