class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea, only: [:create, :destroy]
  before_action :find_review, only: [:destroy]
  before_action :authorize_user!, except: [:create, :destroy]

  def create
    @idea = @idea.reviews.build(review_params)

    @review.user = current_user

    if @review.save
      redirect_to idea_path(@idea)
    else
      @reviews = @idea.reviews.order(created_at: :desc)
      render 'ideas/show'
    end
  end

  def destroy
    authorize! :destroy, @review
    @review.destroy
    redirect_to idea_path(@idea)
  end

  private

  def find_idea
    @idea = Idea.find(params[:idea_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:body)
  end

  def authorize_user!
    # binding.pry
    unless can?(:manage, @review)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end
end
