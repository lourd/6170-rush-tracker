require 'test_helper'

class RusheeTest < ActiveSupport::TestCase

  test "check primary contact names" do

    rusheeA = rushees(:rusheeA)
    rusheeB = rushees(:rusheeB)
    rusheeC = rushees(:rusheeC)

    brotherA = brothers(:brotherA)
    brotherB = brothers(:brotherB)
    brotherC = brothers(:brotherC)

    rusheeB.primary_contact_id = brotherA.id
    rusheeB.save

    assert_equal( rusheeA.primaryContactName, "Unassigned", "A rushee without a primary contact should return Unassigned" ) 
    
    assert_equal( rusheeB.primaryContactName, brotherA.full_name, "Should return the full name of the assigned primary contact" ) 
    
  end

  test "check self full name" do
    rusheeA = rushees(:rusheeA)
    rusheeB = rushees(:rusheeB)
    rusheeC = rushees(:rusheeC)

    assert_equal( rusheeA.full_name, "Test Rushee", "The full name should be Test Rushee" ) 
    
  end

  test "check a rushee can be found by primary contact id" do
    rusheeA = rushees(:rusheeA)
    rusheeB = rushees(:rusheeB)
    rusheeC = rushees(:rusheeC)

    brotherA = brothers(:brotherA)
    brotherB = brothers(:brotherB)
    brotherC = brothers(:brotherC)

    rusheeB.primary_contact_id = brotherA.id
    rusheeB.save

    assert_equal( Rushee.findAllByPrimaryContactID(brotherA.id), [rusheeB], "brotherA is the primary contact for rusheeA" ) 
    
  end

end
