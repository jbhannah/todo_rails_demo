class Todo < ActiveRecord::Base
  before_save :set_completed_at

  belongs_to :user

  default_scope { order "created_at ASC" }

  private
  def set_completed_at
    self.completed_at = Time.now if self.completed?
  end
end
