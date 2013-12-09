require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "Check non attending rushees" do
    rusheeA = rushees(:rusheeA)
    rusheeB = rushees(:rusheeB)
    rusheeC = rushees(:rusheeC)

    eventA = events(:eventA)
    eventB = events(:eventB)
    eventC = events(:eventC)

    fraternity = Fraternity.create()
    eventA.fraternity_id = fraternity.id
    eventA.save()

    assert_equal( [rusheeA, rusheeB].length, eventA.nonAttendingRushees.length, "Only non attending rushees from the same frat should be returned" ) 
    
  end

  test "Check addRushee adds a rushee" do
    rusheeA = rushees(:rusheeA)
    rusheeB = rushees(:rusheeB)
    rusheeC = rushees(:rusheeC)

    eventA = events(:eventA)
    eventB = events(:eventB)
    eventC = events(:eventC)

    fraternity = Fraternity.create()
    eventA.fraternity_id = fraternity.id
    eventA.save()

    eventA.addRushee(rusheeA)

    assert_equal( [rusheeA].length, eventA.rushees.length, "Should only have one attending rushee" ) 
    

    eventA.addRushee(rusheeA)

    assert_equal( [rusheeA].length, eventA.rushees.length, "Adding an existing attending rushee should not add another rushee" ) 
    

    eventA.addRushee(rusheeB)

    assert_equal( [rusheeA, rusheeB].length, eventA.rushees.length, "Adding a non-attending rushee should add another rushee" ) 
    

  end



end
