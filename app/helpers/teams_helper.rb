module TeamsHelper
	def getMatches(team)
		Match.all.where('blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?', "#{team.id}", "#{team.id}", "#{team.id}", "#{team.id}")
	end

	def highScore(team)
		high = 0
		getMatches(team).each do |m|
			if teamScore(m, team) > high
				high = teamScore(m, team)
			end
		end
		high
	end

	def avgCont(team)
		points=0.0
		if (getMatches(team).size > 0)
			getMatches(team).each do |m|
				points += teamScore(m, team) - 0.5*avgScore(partner(m, team))
			end
			(points/getMatches(team).size).round(1)
		else
			0
		end
	end

	def winPerc(team)
		wins = 0.0
		if (getMatches(team).size > 0)
			getMatches(team).each do |m|
				wins += 1 if teamWon?(m, team)
			end
			(100*wins/getMatches(team).size).round(1)
		else
			0
		end
	end

	def avgScore(team)
		points = 0.0
		if (getMatches(team).size > 0)
			getMatches(team).each do |m|
				points += teamScore(m, team)
			end
			(points/getMatches(team).size).round(1)
		else
			0
		end
	end

end
