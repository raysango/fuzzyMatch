class InsuranceMatch < ActiveRecord::Base
  belongs_to :insurance
  class << self
    def get_match(text)
      return unless text.present?
      where("lower(name) = ?", text.downcase).last
    end
  end
end
