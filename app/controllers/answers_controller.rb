class AnswersController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :pick_answer, :vote]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  def destroy
  end

  def pick_answer
    # get picked answer
    answer = Answer.find(params[:answer_id])
    if current_user?(answer.question.user)
      # set selected on other selected answer to false (if exists)
      prev_pick = answer.question.answers.where(selected: true)
      prev_pick.each do |ans|
        ans.update_attributes(selected: false)
      end
      answer.update_attributes(selected: true)
      # redirect to question page
      redirect_to answer.question
    else
      redirect_to root_path
    end
  end

  def vote
    user = current_user
    answer = Answer.find(params[:answer_id])

    vote_string = "#{user.email}_answer_#{answer.id}"
    vote_digest = Digest::MD5.hexdigest vote_string

    # check if cookie exists => user already voted
    if cookies[vote_digest].nil?
      vote = params[:vote]
      if vote == 'up'
        answer.update_attributes(votes: (answer.votes+1))
      elsif vote == 'down'
        answer.update_attributes(votes: (answer.votes-1))
      end

      # set cookie for user vote
      cookies.permanent[vote_digest] = 1
    end

    redirect_to answer.question
  end

  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end
