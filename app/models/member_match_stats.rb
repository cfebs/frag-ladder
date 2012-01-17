class MemberMatchStats < ActiveRecord::Base
  validates :kills, :presence => true, :numericality => true
  validates :deaths, :presence => true, :numericality => true
  validates :points, :presence => true, :numericality => true
end
