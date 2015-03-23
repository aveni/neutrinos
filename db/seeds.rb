# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
include TeamsHelper
include MatchesHelper

teams_text = File.read("#{Rails.public_path}/teams.txt")
events_text = File.read("#{Rails.public_path}/events.txt")
matches_text = File.read("#{Rails.public_path}/matches.txt")

teams = teams_text.split("\n")
events = events_text.split("\n")
matches = matches_text.split("\n")

teams.each do |t|
	arr = t.split("$")
	number = arr[0]
	name = arr[1]
	team = Team.create(number: number, name: name)
	team.save
	puts "Added #{team.number} #{team.name}"
end

events.each do |e|
	arr = e.split("$")
	name = arr[0]
	day = arr[1]
	month = arr[2]
	year = arr[3]
	level = arr[4]
	event = Event.create(name: name, day: day, month: month, year: year, level: level)
	event.save
	puts "Added #{event.name}"
end

matches.each do |m|
	arr = m.split("$")
	number = (arr[0])[1..-1].to_i
	red1_id = Team.where(number: arr[1]).first.id
	red2_id = Team.where(number: arr[2]).first.id
	blue1_id = Team.where(number: arr[3]).first.id
	blue2_id = Team.where(number: arr[4]).first.id
	red_score = arr[5].to_i
	blue_score = arr[6].to_i
	event_id = Event.where(name: arr[7]).first.id
	match = Match.create(number: number, red1_id: red1_id, red2_id: red2_id, blue1_id: blue1_id, blue2_id: blue2_id, 
		red_score: red_score, blue_score: blue_score, event_id: event_id)
	match.save
	addToEvent(match)
	puts "Added Match ##{match.number} to #{match.event.name}"
end

Team.all.each {|t| updateTeam(t)}