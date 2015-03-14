# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :text
#  day        :integer
#  month      :integer
#  year       :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
	has_and_belongs_to_many :matches
	has_many :teams
end
