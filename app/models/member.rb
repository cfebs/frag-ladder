class Member < ActiveRecord::Base
  validates :alias, :presence => true

  belongs_to :team

  has_many :member_match_records
  has_many :matches, :through => :member_match_records


  def plus
    self.matches.where('home_team_id = ?', self.team_id).sum(:home_team_score) +
    self.matches.where('away_team_id = ?', self.team_id).sum(:away_team_score)
  end

  def minus
    self.matches.where('home_team_id = ?', self.team_id).sum(:away_team_score) +
    self.matches.where('away_team_id = ?', self.team_id).sum(:home_team_score)
  end

  def wins
    self.matches.where('home_team_id = ? AND (home_team_score > away_team_score)', self.team_id) +
    self.matches.where('away_team_id = ? AND (home_team_score < away_team_score)', self.team_id)
  end

  def losses
    self.matches.where('home_team_id = ? AND (home_team_score < away_team_score)', self.team_id) +
    self.matches.where('away_team_id = ? AND (home_team_score > away_team_score)', self.team_id)
  end

  def losses
    self.matches.where('home_team_id = ? AND (home_team_score < away_team_score)', self.team_id) +
    self.matches.where('away_team_id = ? AND (home_team_score > away_team_score)', self.team_id)
  end

  def ties
    self.matches.where('home_team_id = ? OR away_team_id = ? AND (home_team_score = away_team_score)', self.team_id, self.team_id)
  end


  def win_percentage
    if !self.matches.empty?
      (self.wins.length.to_f / self.matches.length.to_f) * 100
    else
      0
    end
  end


end
