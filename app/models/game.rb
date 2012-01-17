class Game < ActiveRecord::Base
  validates :name, :presence => true
  validates :abreviation, :presence => true
end
