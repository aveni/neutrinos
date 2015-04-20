module TeamsHelper

	def updateTeam(team)
		team.high_score = highScore(team)
		team.avg_score = avgScore(team)
		team.avg_cont = avgCont(team)
		team.win_perc = winPerc(team)
		team.st_dev = stDev(team)
		team.save
	end

	def updateParticipation(p)
		p.high_score = highScore(p.team, p.event)
		p.avg_score = avgScore(p.team, p.event)
		p.avg_cont = avgCont(p.team, p.event)
		p.win_perc = winPerc(p.team, p.event)
		p.st_dev = stDev(p.team, p.event)
		qp = QP(p.event)
		p.numMatches = qp[p.team.number][0]
		p.curMatches = qp[p.team.number][2]
		p.qp = qp[p.team.number][1]
		p.opr = OPR(p.event)[p.team.number]
		p.save
		updateTeam(p.team)
	end

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
