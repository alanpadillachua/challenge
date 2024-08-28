class Subscriber < ApplicationRecord
  before_validation :formatEmail

  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :status, presence: true, inclusion: ["active", "inactive"]

  private

  def formatEmail
    self.email = email.downcase.strip if email.present?
  end
end
