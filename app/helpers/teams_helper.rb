module TeamsHelper

	def getEventMatches(team, event)
		event.matches.select{|m| hasTeam(m, team)}
	end


	def highScore(matches, team)
		high = 0
		tmatches = matches.select{|m| hasTeam(m, team)}
		tmatches.each do |m|
			if teamScore(m, team) > high
				high = teamScore(m, team)
			end
		end
		high
	end

	def avgCont(matches, team)
		points=0.0
		tmatches = matches.select{|m| hasTeam(m, team)}
		if tmatches.size > 0
			tmatches.each do |m|
				points += teamScore(m, team) - 0.5*avgScore(m.event.matches, partner(m, team))
			end
			(points/tmatches.size).round(1)
		else
			0
		end
	end

	def winPerc(matches, team)
		wins = 0.0
		tmatches = matches.select{|m| hasTeam(m, team)}
		if tmatches.size > 0
			tmatches.each do |m|
				wins += 1 if teamWon?(m, team)
			end
			(100*wins/tmatches.size).round(1)
		else
			0
		end
	end

	def avgScore(matches, team)
		points = 0.0
		tmatches = matches.select{|m| hasTeam(m, team)}
		if tmatches.size > 0
			tmatches.each do |m|
				points += teamScore(m, team)
			end
			(points/tmatches.size).round(1)
		else
			0
		end
	end

	def stDev(matches, team)
		scores=[]
		tmatches = matches.select{|m| hasTeam(m, team)}
		if tmatches.size > 0
			tmatches.each do |m|
				scores << teamScore(m, team)
			end
			avg = 0.0
			scores.each {|s| avg += s} 
			avg /= scores.size
			sum = 0.0
			scores.each {|s| sum += (s-avg)**2}
			sum /= scores.size
			(sum**0.5).round(1)
		else
			0
		end
	end

end
