class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_submission

  def index
  end

  def show
  end

  def new
  end

  def create
    @comment = @submission.comments.create(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to submission_path(@submission), notice: 'Comment created successfully' }
      else
        format.turbo_stream
        format.html { redirect_to submission_path(@submission), alert: 'Comment could not be created' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream
        format.html { redirect_to submission_path(@submission), notice: 'Comment updated successfully' }
      else
        format.turbo_stream
        format.html { redirect_to submission_path(@submission), alert: 'Comment could not be updated' }
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to submission_path(@submission), notice: 'Comment deleted'

    # respond_to do |format|
    #   format.turbo_stream { turbo_stream.remove(@comment) }
    #   format.html { redirect_to submission_path(@submission), notice: 'Comment deleted' }
    # end
  end

  def upvote
    respond_to do |format|
      puts "*1*"
      unless current_user.voted_for? @comment
        puts "*2*"
        @comment.upvote_by current_user
        format.turbo_stream {
        puts "*3*"
          render turbo_stream: turbo_stream.replace(
            "#{dom_id(@comment)}_votes_count",
            @comment.total_vote_count
          )
        }
        # format.html { redirect_back(:fallback_location root_path) }
      else
        format.html { redirect_to submission_path(@submission), alert: 'You already voted for this comment' }
      end
    end
  end

  def downvote
    respond_to do |format|
      puts "*1*"
      unless current_user.voted_for? @comment
        puts "*2*"
        @comment.downvote_by current_user
        format.turbo_stream {
        puts "*3*"
          render turbo_stream: turbo_stream.replace(
            "#{dom_id(@comment)}_votes_count",
            @comment.total_vote_count
          )
        }
        # format.html { redirect_back(:fallback_location root_path) }
      else
        format.html { redirect_to submission_path(@submission), alert: 'You already voted for this comment' }
      end
    end
  end

  private

  def set_submission
    @submission = Submission.find(params[:submission_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:reply, :submission_id)
  end

end
