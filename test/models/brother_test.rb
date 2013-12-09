require 'test_helper'

class BrotherTest < ActiveSupport::TestCase
  test "Affirm Verification" do

    brotherA = brothers(:brotherA)
    brotherB = brothers(:brotherB)
    brotherC = brothers(:brotherC)

    Brother.verify(brotherA.id)

    assert_equal( brotherA.is_verified, true, "A already verified brother should remain verified" )
    assert_equal( brotherB.is_verified, false, "A pending brother should be un verified" )

    Brother.verify(brotherB.id)

    # This test is failing even though it should be passing

    assert_equal( true, brotherB.is_verified, "A pending brother who is verified should become verified")

  end
end
