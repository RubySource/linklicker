class Link < ActiveRecord::Base

  belongs_to(:user)
  has_many :licks
  validates :url, presence: true

  def licked_by? user
    false unless user
    licks.where(user_id: user.id).first.present?
  end
end
