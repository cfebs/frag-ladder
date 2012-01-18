class TeamMember < ActiveRecord::Base
  belongs_to :member
  belongs_to :team

  validate :unique_alias_per_team

  def unique_alias_per_team
    self.team.members.each do |m|
      if m.alias == self.member.alias
        errors[:base] << 'Member aliases per team must be unique'
        return
      end
    end
  end
end
