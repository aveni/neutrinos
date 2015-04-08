module EventsHelper
	require 'matrix'

	def show_date(event)
		"#{event.month}/#{event.day}/#{event.year}"
	end

	def show_level(event)
		content_tag(:span, event.level, class: "label label-warning label-as-badge")
	end

	def QP(event)
		teams = event.teams

		map = {}
		for i in 0..teams.size-1
			map[teams[i].number] = i
		end

		arr = Array.new(teams.size) {Array.new(2) {0}}		

		event.matches.includes(:red1, :red2, :blue1, :blue2).each do |m|
			r1 = map[m.red1.number]
			r2 = map[m.red2.number]
			b1 = map[m.blue1.number]
			b2 = map[m.blue2.number]

			arr[r1][0] += 1
			arr[r2][0] += 1
			arr[b1][0] += 1
			arr[b2][0] += 1

			n = winningAlliance(m)
			if n == -1
				arr[r1][1] += 2
				arr[r2][1] += 2
			elsif n == 1
				arr[b1][1] += 2
				arr[b2][1] += 2
			else
				arr[r1][1] += 1
				arr[r2][1] += 1
				arr[b1][1] += 1
				arr[b2][1] += 1	
			end
		end

		hash = {}
		map.each do |k,v|
			hash[k] = arr[v]
		end
		hash
	end


	def OPR(event)
		teams = event.teams

		map = {}
		for i in 0..teams.size-1
			map[teams[i].number] = i
		end

		arr = Array.new(teams.size) {Array.new(teams.size) {0}}		
		b = Array.new(teams.size) {0}

		event.matches.includes(:red1, :red2, :blue1, :blue2).each do |m|
			r1 = map[m.red1.number]
			r2 = map[m.red2.number]
			b1 = map[m.blue1.number]
			b2 = map[m.blue2.number]

			arr[r1][r1] += 1
			arr[r2][r2] += 1
			arr[b1][b1] += 1
			arr[b2][b2] += 1

			arr[r1][r2] += 1
			arr[r2][r1] += 1
			arr[b1][b2] += 1
			arr[b2][b1] += 1

			b[r1] += m.red_score
			b[r2] += m.red_score
			b[b1] += m.blue_score
			b[b2] += m.blue_score

		end


		mat = Matrix[*arr]
		solve = mat.lup.solve(b) rescue Array.new(teams.size){0}

		opr = {}
		map.each do |k,v|
			opr[k] = solve[v].to_f
		end

		opr
	end

end
