# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  votes       :integer          default(0)
#  selected    :boolean          default(FALSE)
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :content, presence: true
  validates :user_id, presence: true
  validates :question_id, presence: true

end
