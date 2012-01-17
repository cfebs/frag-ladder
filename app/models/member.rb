class Member < ActiveRecord::Base
  validates :alias, :presence => true
  has_and_belongs_to_many :teams
end
