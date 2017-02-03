class User < ApplicationRecord
  before_save {email.downcase!}
  validates(:name, 
            presence: true, 
            length: {maximum: 50}
            )
  validates(:email, 
            presence: true, 
            length: {maximum: 255}, 
            uniqueness: { case_sensitive: false },
            format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
            )
  has_secure_password
  validates(:password,
            presence: true,
            length: {minimum: 6}
            )
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
