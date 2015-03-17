module TeamsHelper


	def highScore(team, event=nil)
		high = 0
		event == nil ? matches = getMatches(team) : matches = getEventMatches(team, event)
		matches.each do |m|
			if teamScore(m, team) > high
				high = teamScore(m, team)
			end
		end
		high
	end

	def avgCont(team, event=nil)
		points=0.0
		event == nil ? matches = getMatches(team) : matches = getEventMatches(team, event)
		if matches.size > 0
			matches.each do |m|
				points += teamScore(m, team) - 0.5*avgScore(partner(m, team), m.event)
			end
			(points/matches.size).round(1)
		else
			0
		end
	end

	def winPerc(team, event=nil)
		wins = 0.0
		event == nil ? matches = getMatches(team) : matches = getEventMatches(team, event)
		if matches.size > 0
			matches.each do |m|
				wins += 1 if teamWon?(m, team)
			end
			(100*wins/matches.size).round(1)
		else
			0
		end
	end

	def avgScore(team, event=nil)
		points = 0.0
		event == nil ? matches = getMatches(team) : matches = getEventMatches(team, event)
		if matches.size > 0
			matches.each do |m|
				points += teamScore(m, team)
			end
			(points/matches.size).round(1)
		else
			0
		end
	end

	def stDev(team, event=nil)
		scores=[]
		event == nil ? matches = getMatches(team) : matches = getEventMatches(team, event)
		if matches.size > 0
			matches.each do |m|
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
