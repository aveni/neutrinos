module TeamsHelper


	def highScore(matches, team)
		high = 0
		matches.each do |m|
			if teamScore(m, team) > high
				high = teamScore(m, team)
			end
		end
		high
	end

	def avgCont(matches, team)
		points=0.0
		num = 0
		if matches.size > 0
			matches.each do |m|
				if hasTeam(m, team)
					points += teamScore(m, team) - 0.5*avgScore(m.event.matches, partner(m, team))
					num += 1
				end
			end
			(points/num).round(1)
		else
			0
		end
	end

	def winPerc(matches, team)
		wins = 0.0
		num = 0
		if matches.size > 0
			matches.each do |m|
				if hasTeam(m, team)
					wins += 1 if teamWon?(m, team)
					num += 1
				end
			end
			(100*wins/num).round(1)
		else
			0
		end
	end

	def avgScore(matches, team)
		points = 0.0
		num = 0
		if matches.size > 0
			matches.each do |m|
				if hasTeam(m, team)
					points += teamScore(m, team)
					num += 1
				end
			end
			(points/num).round(1)
		else
			0
		end
	end

	def stDev(matches, team)
		scores=[]
		if matches.size > 0
			matches.each do |m|
				if hasTeam(m, team)
					scores << teamScore(m, team)
				end
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
