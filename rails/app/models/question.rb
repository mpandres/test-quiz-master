class Question < ActiveRecord::Base

  validates_presence_of :question
  validates_presence_of :answer

  def is_correct?(submission)
    unless answer.simplify == submission.simplify
      return answer.to_word == submission.to_word
    end

    return true
  end

end
