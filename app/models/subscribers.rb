class Subscribers < ApplicationRecord
  before_validation :formatEmail

  validates :name, presence: true
  validates :email, email: true, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :status, presence: true, inclusion: ["active", "inactive"]

  private

  def formatEmail
    self.email = email.downcase.strip if email.prensent?
  end
end
