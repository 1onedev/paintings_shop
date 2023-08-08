class User < ApplicationRecord
  include PgSearch

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders, dependent: :destroy, inverse_of: :user

  def full_name
    [name, surname].compact.join(' ')
  end

  scope :search, ->(q) { pg_search(q) if q.present? }
  pg_search_scope :pg_search, against: [:name, :surname, :email],
                              using: {
                                tsearch: { prefix: true, any_word: true }
                              }
end
