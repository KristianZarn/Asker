class QuestionsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :vote]

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

  def vote
    user = current_user
    question = Question.find(params[:question_id])

    vote_string = "#{user.email}_question_#{question.id}"
    vote_digest = Digest::MD5.hexdigest vote_string

    # check if cookie exists => user already voted
    if cookies[vote_digest].nil?
      vote = params[:vote]
      if vote == 'up'
        question.update_attributes(votes: (question.votes+1))
      elsif vote == 'down'
        question.update_attributes(votes: (question.votes-1))
      end

      # set cookie for user vote
      cookies.permanent[vote_digest] = 1
    end

    redirect_to question
  end

  private
  def question_params
    params.require(:question).permit(:title, :content)
  end
end
