class League < ActiveRecord::Base
  validates :name, :presence => true
  has_and_belongs_to_many :teams
  has_many :seasons
end
