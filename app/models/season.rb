class Season < ActiveRecord::Base
  validates :name, :presence => true
  has_and_belongs_to_many :teams
  has_many :matches
  belongs_to :league

  def phase_two_date
    Time.now + 2.weeks
  end
end
