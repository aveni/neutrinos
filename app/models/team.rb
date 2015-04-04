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

	has_many :participations, dependent: :destroy
	has_many :events, :through=>:participations

	validates :number, presence:true, uniqueness:true, :numericality => {:greater_than => 0}
	validates :name, presence:true

	def show_team
		"#{number} #{name}"
	end
end
