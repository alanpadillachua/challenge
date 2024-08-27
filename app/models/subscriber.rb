class Subscriber < ApplicationRecord
  ACTUAL_EMAIL_REGEX = /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+\z/
  before_validation :formatEmail

  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: ACTUAL_EMAIL_REGEX
  validates :status, presence: true, inclusion: ["active", "inactive"]

  private

  def formatEmail
    self.email = email.downcase.strip if email.present?
  end
end
