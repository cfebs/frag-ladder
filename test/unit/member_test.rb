require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "should not save without alias" do
    member = Member.new
    assert !member.save
  end
end
