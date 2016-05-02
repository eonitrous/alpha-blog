class Category < ActiveRecord::Base

  #associate categories table to articles table throuh article_categories table
  has_many :article_categories
  has_many :articles, through: :article_categories

  #validation rules for this table
  validates :name, presence: true, length: {minimum: 3, maximum: 25}
  validates_uniqueness_of :name

end