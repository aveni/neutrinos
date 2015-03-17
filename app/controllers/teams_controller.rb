class TeamsController < ApplicationController
	include TeamsHelper
	include MatchesHelper
  before_action :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource

	def index
		@teams = Team.all
	end

	def new
		@team = Team.new
	end

	def show
		@team = Team.find(params[:id])
	end

	def edit
		@team = Team.find(params[:id])
	end

	def create
		@team = Team.new(team_params)
		if @team.save
			redirect_to @team, notice:'Team successfully created'
		else
			render 'new'
		end
	end

	def update
		@team = Team.find(params[:id])
		if @team.update(team_params)
			redirect_to @team, notice:'Team successfully updated'
		else
			render 'edit'
		end
	end

	def destroy
		@team = Team.find(params[:id])
		@team.destroy unless @team.nil?
		redirect_to teams_path
	end	

	private

		def team_params
			params[:team].permit(:number, :name)
		end


end
