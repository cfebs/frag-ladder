class Team < ActiveRecord::Base
  validates :name, :presence => true
  validates :tag, :presence => true

  has_and_belongs_to_many :members
  has_and_belongs_to_many :leagues
end
