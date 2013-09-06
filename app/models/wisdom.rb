class Wisdom < ActiveRecord::Base
  has_many :comments
  validates :quote, presence:true,
                    length: { minimum: 2 }
  validates :author, presence:true,
                    length: { minimum: 2 }
end
