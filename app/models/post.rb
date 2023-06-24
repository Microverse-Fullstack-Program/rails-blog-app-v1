class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :author_id, counter_cache: :posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true, length: { maximum: 1000 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter
  after_destroy :update_posts_counter

  def update_posts_counter
    if destroyed?
      author.decrement!(:posts_counter)
      return
    end
    author.increment!(:posts_counter)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def recent_likes(limit = 3)
    likes.order(created_at: :desc).limit(limit)
  end
end
