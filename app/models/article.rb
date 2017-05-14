class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: {minimum: 5}
  validate :unique?


  def summary
    text[0..32]
  end


  def unique?
    if Article.where(:title => title).any?
      errors.add(:title, "already in use!")
    end

  end

end
