# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  votes      :integer          default(0)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true

end
