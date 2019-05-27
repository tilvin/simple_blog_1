class Post < ApplicationRecord
  belongs_to :user, counter_cache: true

  validates :title, :description, :user_id, presence: true

  has_one_attached :cover_image, dependent: :destroy
end
