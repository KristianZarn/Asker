class AnswersController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

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

  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end
