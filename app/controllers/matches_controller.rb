class MatchesController < ApplicationController

	def index
		@matches = Match.all.order(:number)
	end

	def new
		@match = Match.new
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
			redirect_to matches_path, notice:'Match successfully created'
		else
			render 'new'
		end
	end

	def update
		@match = Match.find(params[:id])
		if @match.update(match_params)
			redirect_to matches_path, notice:'Match successfully updated'
		else
			render 'edit'
		end
	end

	def destroy
		@match = Match.find(params[:id])
		@match.destroy unless @match.nil?
		redirect_to matches_path
	end	

	private

		def match_params
			params[:match].permit(:number, :blue1_id, :blue2_id, :red1_id, :red2_id, :blue_score, :red_score)
		end


end
