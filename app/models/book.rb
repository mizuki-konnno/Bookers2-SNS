class Book < ApplicationRecord

	belongs_to :user
	has_many :book_comments,dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	is_impressionable counter_cache: true

	scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_twodaysago, -> { where(created_at: 2.day.ago.all_day) } # ２日前
  scope :created_threedaysago, -> { where(created_at: 3.day.ago.all_day) } # ３日前
  scope :created_fourdaysago, -> { where(created_at: 4.day.ago.all_day) } # ４日前
  scope :created_fivedaysago, -> { where(created_at: 5.day.ago.all_day) } # ５日前
  scope :created_sixdaysago, -> { where(created_at: 6.day.ago.all_day) } # ６日前
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 前週

def self.looks(words)
  @book_search =Book.where("created_at LIKE?","#{words}")
end

end
