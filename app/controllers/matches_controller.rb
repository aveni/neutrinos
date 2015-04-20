class MatchesController < ApplicationController
	include TeamsHelper
	include MatchesHelper
	include EventsHelper

	before_action :set_event
	before_action :authenticate_user!, except: [:show]
	load_and_authorize_resource


	def new
		@match = Match.new(event_id: @event.id, blue_score: 0, red_score: 0)
	end

	def show
		@match = Match.find(params[:id])
	end

	def edit
		@match = Match.find(params[:id])
	end

	def create
		@match = Match.new(match_params)
		if @match.save
			addToEvent(@match)
			updateEvent(@event)
			redirect_to @event, notice:'Match successfully created'
		else
			render 'new'
		end
	end

	def update
		@match = Match.find(params[:id])
		if @match.update(match_params)
			addToEvent(@match)
			updateEvent(@event)
			redirect_to @event, notice:'Match successfully updated'
		else
			render 'edit'
		end
	end

	def destroy
		@match = Match.find(params[:id])
		@match.destroy unless @match.nil?
		updateEvent(@event)
		redirect_to @event
	end	

	private

		def match_params
			params[:match].permit(:number, :event_id, :blue1_id, :blue2_id, :red1_id, :red2_id, :blue_score, :red_score)
		end

		def set_event
			@event = Event.find(params[:event_id])
		end


end
