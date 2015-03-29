class EventsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource
	include TeamsHelper
	include MatchesHelper

	def index
			@events = Event.all.order(:name)
	end

	def new
		@event = Event.new
	end

	def show
		@event = Event.find(params[:id])
	end

	def edit
		@event = Event.find(params[:id])
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to @event, notice:'Event successfully created'
		else
			render 'new'
		end
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			redirect_to @event, notice:'Event successfully updated'
		else
			render 'edit'
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy unless @event.nil?
		Team.all.each {|t| updateTeam(t)}
		redirect_to events_path
	end	

	private

		def event_params
			params[:event].permit(:name, :day, :month, :year, :level)
		end

end
