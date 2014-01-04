class QuestionsController < ApplicationController
  before_filter :signed_in_user, only: [:create]

  def index
    qpp = 4 # questions per page
    if params[:order] == "votes"
      @questions = Question.order(votes: :desc).paginate(page: params[:page], per_page: qpp)
    elsif params[:order] == "unanswered"
      @questions = Question.includes(:answers).group('questions.id').having('COUNT(answers.id) = 0').references(:answers)
      @questions = @questions.order(created_at: :desc).paginate(page: params[:page], per_page: qpp)
    else
      @questions = Question.order(created_at: :desc).paginate(page: params[:page], per_page: qpp)
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order(votes: :desc)
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to root_path
    else
      render 'questions/index'
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :content)
  end
end
