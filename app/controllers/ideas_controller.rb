class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, except: [:index, :show, :new, :create]

  def new
    @idea = Idea.new
  end

  def create
    # idea_params = params.require(:idea).permit(:title, :description)
    @idea = Idea.new idea_params
    @idea.user = current_user

    if @idea.save
      # flash notice
      redirect_to root_path

    else
      render :new

    end
  end

  def show
    # @idea = Idea.find params[:id]
    @review = @idea.reviews.new
    # @review = Review.new
  end

  def edit
    # @idea = Idea.find params[:id]

  end

  def update
    # return head :unauthorized unless can?(:update, @idea)
    idea_params = params.require(:idea).permit(:title, :description)
    #  @idea = Idea.find params[:id]
  if @idea.update idea_params
    redirect_to @idea
  else
    render :edit
    end
  end

  def index
  @ideas = Idea.order(created_at: :desc)
  end

  def destroy
    # @post = Post.find params[:id]
    @idea.delete
    redirect_to ideas_path
  end


  private
  def find_idea
    @idea = Idea.find params[:id]
  end
  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:reviews).permit(:body)
  end
  #
  def authorize_user!
    # binding.pry
    unless can?(:manage, @idea)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end
end
