class Book < ApplicationRecord

  belongs_to:user

  has_many:favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many:book_comments
  has_many:view_counts
  has_many:book_tags,dependent: :destroy
  has_many:tags,through: :book_tags

  validates:title,presence:true
  validates:body,{presence:true,length:{maximum:200}}

  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end

  def self.search(search_word)
    Book.where(['tag LIKE?',"#{search_word}"])
  end

  def self.search_for(content,method)
    if method=="perfect"
      Book.where(title:content)
    elsif method=="forward"
      Book.where('title LIKE?',content+'%')
    elsif method=="backward"
      Book.where('title LIKE?','%'+content)
    else
      Book.where('title LIKE?','%'+content+'%')
    end
  end

  scope:latest,->{order(created_at: :desc)}
  scope:old,->{order(created_at: :asc)}
  scope:star_count,->{order(star: :desc)}

  scope:created_today,->{where(created_at:Time.zone.now.all_day)}
  scope:created_yesterday,->{where(created_at:1.day.ago.all_day)}
  scope:created_two_days_ago,->{where(created_at:2.days.ago.all_day)}
  scope:created_three_days_ago,->{where(created_at:3.days.ago.all_day)}
  scope:created_four_days_ago,->{where(created_at:4.days.ago.all_day)}
  scope:created_five_days_ago,->{where(created_at:5.days.ago.all_day)}
  scope:created_six_days_ago,->{where(created_at:6.days.ago.all_day)}
  scope:created_this_week,->{where(created_at:Time.current.all_week)}
  scope:created_last_week,->{where(created_at:Time.current.last_week.all_week)}
end
