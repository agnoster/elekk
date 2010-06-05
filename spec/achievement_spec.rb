require 'elekk'
include Elekk

describe Achievement do
  before :each do
    @achievements = Character.new('Fyrbard','Uldaman').achievements(:Raid)
    @oncebitten = @achievements.find {|a| a.id == 4539 }
    @lk25 = @achievements.find {|a| a.id == 4608 }
  end

  it "should give a list of achievements" do
    @oncebitten.should_not be_nil
    @lk25.should_not be_nil
  end
  
  it "should have the correct title" do
    @oncebitten.title.should == 'Once Bitten, Twice Shy (10 player)'
  end
  
  it "should have the correct icon" do
    @oncebitten.icon.should == 'achievement_boss_lanathel'
  end
  
  it "should have the correct category" do
    @oncebitten.category.to_s.should == "Dungeons & Raids"
  end
  
  it "should have the correct point total as an integer" do
    @oncebitten.points.should == 10
  end
  
  it "should have the correct time of completion" do
    @oncebitten.completed.to_i.should == 1274250840
    @lk25.completed.should be_nil
  end
  
  it "should show correct completion state" do
    @oncebitten.complete?.should == true
    @lk25.complete?.should == false
  end
  
  it "should get the correct information to display on wowhead" do
    @oncebitten.wowhead.url.should == 'http://www.wowhead.com/achievement=4539'
    @oncebitten.wowhead.icon_url(:large).should == 'http://static.wowhead.com/images/wow/icons/large/achievement_boss_lanathel.jpg'
  end
end


