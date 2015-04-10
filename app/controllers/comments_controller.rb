class CommentsController < ApplicationController
	load_and_authorize_resource

	def new
		if params[:type] == 'team'
			@commentable = Team.find(params[:team_id])
		elsif params[:type] == 'match'
			@commentable = Match.find(params[:match_id])
		end
		@comment = @commentable.comments.new
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			redirect_to @comment.commentable, notice:'Comment successfully created' if @comment.commentable_type == "Team"
			redirect_to event_match_path(@comment.commentable.event, @comment.commentable), notice:'Comment successfully created' if @comment.commentable_type == "Match"
		else
			render 'new'
		end
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			redirect_to @comment.commentable, notice:'Comment successfully updated' if @comment.commentable_type == "Team"
			redirect_to event_match_path(@comment.commentable.event, @comment.commentable), notice:'Comment successfully created' if @comment.commentable_type == "Match"
		else
			render 'edit'
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@commentable = @comment.commentable
		type = @comment.commentable_type
		@comment.destroy unless @comment.nil?
		redirect_to @commentable if type == "Team"
		redirect_to event_match_path(@commentable.event, @commentable) if type == "Match"

	end	

	private

		def comment_params
			params[:comment].permit(:body, :author, :commentable_id, :commentable_type)
		end
end
