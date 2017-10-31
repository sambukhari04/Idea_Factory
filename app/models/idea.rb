class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates(:title,{
    presence: {message: 'must be provided'},
    uniqueness: true
    })
    validates(:description, {
      presence: true,
      length: {minimum: 20, maximum:2000}
    })
end
