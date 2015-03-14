module TeamsHelper
	def getMatches(team)
		Match.all.where('blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?', "#{@team.id}", "#{@team.id}", "#{@team.id}", "#{@team.id}")
	end
end
