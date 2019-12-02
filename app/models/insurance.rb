class Insurance < ActiveRecord::Base
  has_many :insurance_matches
  validates_uniqueness_of :name

  class << self

    def get_insurance(text)
      return [] unless text.present?
      where("lower(name) = ?", text.downcase).last
    end

  end
end