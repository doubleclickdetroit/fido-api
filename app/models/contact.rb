class Contact < ActiveRecord::Base
  has_many :occasions, dependent: :destroy
end
