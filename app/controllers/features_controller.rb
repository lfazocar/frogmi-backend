class FeaturesController < ApplicationController

  # GET /features
  def index
    @features = Feature.all

    render json: @features
  end

  # POST /features/:id/comments
  def comment
    @comment = Comment.new(comment_params.merge(feature_id: params[:id]))

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
