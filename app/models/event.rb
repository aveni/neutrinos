# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :text
#  day        :integer
#  month      :integer
#  year       :integer
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
	has_and_belongs_to_many :teams
	has_many :matches, dependent: :destroy

	validates :day, presence:true
	validates :month, presence:true
	validates :year, presence:true
	validates :name, presence:true, uniqueness:true
	validates :level, presence:true, inclusion: {in: LEVELS}
end
