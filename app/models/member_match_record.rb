class MemberMatchRecord < ActiveRecord::Base
  validates :kills, :presence => true, :numericality => true
  validates :deaths, :presence => true, :numericality => true
  validates :points, :presence => true, :numericality => true

  belongs_to :match
  belongs_to :member
end
