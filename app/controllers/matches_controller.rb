class MatchesController < ApplicationController
	include TeamsHelper
	include MatchesHelper
	before_action :set_event
	before_action :authenticate_user!, except: [:show]


	def new
		@match = Match.new(event_id: @event.id)
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
			updateEvent(@match)
			redirect_to @event, notice:'Match successfully created'
		else
			render 'new'
		end
	end

	def update
		@match = Match.find(params[:id])
		if @match.update(match_params)
			updateEvent(@match)
			redirect_to @event, notice:'Match successfully updated'
		else
			render 'edit'
		end
	end

	def destroy
		@match = Match.find(params[:id])
		@match.destroy unless @match.nil?
		cleanEvent(@event)
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
