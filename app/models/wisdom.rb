class Wisdom < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :quote, presence:true,
                    length: { minimum: 2 }
  validates :author, presence:true,
                    length: { minimum: 2 }
  self.per_page = 3 
end
