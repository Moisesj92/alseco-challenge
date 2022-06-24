class Product < ApplicationRecord
  belongs_to :user

  enum status: { draft: 0, published: 1 }

end
