require 'elekk'
include Elekk

describe Wowhead, '#search' do
  before :each do
    @q = Wowhead.search 'Varian'
  end
  
  it "should make search queries" do
    @q.should_not be_nil
  end
  
  it "should return good results" do
    @q[0].kind.should == Kind::Item
    @q[0].quality.should == Quality::Poor
    @q[1].quality.should == Quality::Common
    @q[2].quality.should == Quality::Epic
    @q[3].kind.should == Kind['Object']
    @q[4].kind.should == Kind::NPC
  end
  
  it "should give links for results" do
    @q[0].url.should == 'http://www.wowhead.com/item=43680'
    @q[1].to_html.should == "<a href='http://www.wowhead.com/item=43440' class='q1'>To King Varian Wrynn of the Alliance</a>"
  end
  
  it "should give icons for results" do
    @q[0].icon_url.should == 'http://static.wowhead.com/images/wow/icons/medium/INV_Misc_Coin_18.jpg'
    @q[1].icon_url(:small).should == 'http://static.wowhead.com/images/wow/icons/small/INV_Scroll_15.jpg'
    @q[2].icon_url(:large).should == 'http://static.wowhead.com/images/wow/icons/large/INV_Misc_Cape_16.jpg'
  end
  
  it "should be correct when parsed from HTML" do
    r = Wowhead::Result.from_html "<a href='http://www.wowhead.com/item=47547' class='q4'>Varian's Furor</a>"
    r.to_html.should == "<a href='http://www.wowhead.com/item=47547' class='q4'>Varian's Furor</a>"
  end
end