class Article < ActiveRecord::Base
  
  # association declaration to user table
  belongs_to :user
  
  #associate this table to categories through article_categories
  has_many :article_categories
  has_many :categories, through: :article_categories

  #validation rules for title field
  validates :title, presence: true, length: { minimum: 3, maximum: 50}
  
  #validation rules for description field
  validates :description, presence: true, length: { minimum: 10, maximum: 300}
  
  #validation rules for user_id field
  validates :user_id, presence: true

end