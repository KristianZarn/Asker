class AnswersController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :pick_answer]

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

  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end
