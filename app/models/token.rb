class Token < ActiveRecord::Base
  belongs_to :account
  belongs_to :app

  before_create do |t|
    t.token = SecureRandom.hex(16)
  end
end
