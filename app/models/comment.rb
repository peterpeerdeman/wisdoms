class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :wisdom

  self.per_page = 30
end
