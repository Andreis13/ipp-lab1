class Account < ActiveRecord::Base
  has_many :tokens
end
