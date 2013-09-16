class Wisdom < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :user
  has_many :comments
  validates :quote, presence:true,
                    length: { minimum: 2 }
  validates :author, presence:true,
                    length: { minimum: 2 }
  self.per_page = 30

  def slug_candidates
    [
      :quote,
      [:quote, :author],
      [:quote, :author, :user_id]
    ]
  end

end
