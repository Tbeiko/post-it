class Post < ActiveRecord::Base
  PER_PAGE = 7

  include VoteableTimBeiko
  include Slugable

  default_scope { order('created_at ASC')}

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 3}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  slugable_column :title

end 