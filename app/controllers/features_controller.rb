class FeaturesController < ApplicationController
  wrap_parameters :comment, include: :body

  # GET /features
  def index
    features = Feature.all

    if params['mag_type']
      mag_types = ['md', 'ml', 'ms', 'mw', 'me', 'mi', 'mb', 'mlg']
      mag_intersection = mag_types & params['mag_type']
      unless mag_intersection.blank?
        features = features.where(mag_type: params["mag_type"])
      end
    end

    per_page = params['per_page'].to_i
    if per_page < 1
      per_page = 1
    elsif per_page > 1000
      per_page = 1000
    end

    page = params['page'].to_i
    total = features.size
    if page < 1
      page = 1
    elsif page * per_page > total
      page, remainder = total.divmod(per_page)
      page += 1 if remainder > 0 || page == 0
    end

    page_offset = (page - 1) * per_page
    features = features.limit(per_page).offset(page_offset)

    features_hash = FeatureSerializer.new(features).serializable_hash
    pagination_hash = {
      'pagination': {
        'current_page': page,
        'total': total,
        'per_page': per_page
      }
    }

    render json: features_hash.merge(pagination_hash)
  end

  # POST /features/:id/comments
  def comment
    comment = Comment.new(comment_params.merge(feature_id: params[:feature_id]))

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  # GET /features/:id/comments
  def feature_comments
    comments = Comment.where(feature_id: params[:feature_id])
    render json: comments
  end

  # GET /features/comments
  def all_comments
    comments = Comment.all
    render json: comments
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
