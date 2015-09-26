class Occasion < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact

  before_save :ensure_date_is_future

  scope :current, ->(start_date, end_date) {
    where("date between ? and ?", start_date, end_date)
  }

  private
    def ensure_date_is_future
      today = Date.today
      today < self.date
    end
end
