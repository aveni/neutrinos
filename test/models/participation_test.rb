# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  event_id   :integer
#  high_score :integer
#  avg_score  :float
#  win_perc   :float
#  avg_cont   :float
#  st_dev     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  qp         :integer
#  numMatches :integer
#  opr        :float
#

require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
