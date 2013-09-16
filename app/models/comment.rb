class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :wisdom

  validates :body, presence:true,
                    length: { minimum: 1 }
  self.per_page = 30
end
