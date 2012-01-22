require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test team points
  #
  # Team1: 1 win, 0 loss, 1 tie
  #   1 win + first play = 4
  #   1 tie = 2
  #   6 points total
  #
  # Team2: 0 win, 1 loss, 1 tie
  #   0 win + first play = 1
  #   1 tie = 2
  #   3 points total

  def setup
    @team1 = {:wins => 1, :losses => 0, :ties => 1}
    @team2 = {:wins => 0, :losses => 1, :ties => 1}
  end

  def teardown
    @team1 = @team2 = nil
  end

  test "wins should be counted" do
    assert_equal teams(:team1).wins.length, 1
    assert_equal teams(:team2).wins.length, 0
  end

  test "win points should be summed correctly" do
    assert_equal teams(:team1).wins_plus_handicap, 3
    assert_equal teams(:team2).wins_plus_handicap, 0
  end

  # ties
  test "tie points should be summed" do
    assert_equal teams(:team1).ties_plus_handicap, 1
    assert_equal teams(:team2).ties_plus_handicap, 1
  end

  #losses
  test "losses should be counted" do
    assert_equal teams(:team1).losses.length, 0
    assert_equal teams(:team2).losses.length, 1
  end

  test "losses points should be summed" do
    assert_equal teams(:team1).losses_plus_handicap, 0
    assert_equal teams(:team2).losses_plus_handicap, 0 #first
  end

  test "total_points should be talleyed" do
    win_points = Team::WIN_VALUE * @team1[:wins] + Team::FIRST_PLAY_BONUS
    tie_points = Team::TIE_VALUE * @team1[:ties]
    expected = win_points + tie_points

    assert_equal expected, teams(:team1).total_points

    #team2
    tie_points = Team::TIE_VALUE * @team2[:ties] + Team::FIRST_PLAY_BONUS
    loss_points = 0 * @team2[:losses]

    expected = tie_points + loss_points

    assert_equal expected, teams(:team2).total_points

  end

  # dynamic points tests, as matches get added
  # make sure points change
  test "subsequent matches should not give first_play bonus" do
    # new match
    assert_equal teams(:team1).first_played_bonus, 1
    assert_equal teams(:team2).first_played_bonus, 1

    Match.create(:home_team_id => teams(:team1).id,
      :away_team_id => teams(:team2).id,
      :home_team_score => 0,
      :away_team_score => 1)

    assert_equal teams(:team1).first_played_bonus, 1
    assert_equal teams(:team2).first_played_bonus, 1

  end

end
