require 'elekk'
include Elekk

describe Character do
  before :each do
    armory = Armory.new 'Uldaman', :us
    @fyrbard = armory.character 'Fyrbard'
    @aldea = Character.new 'Aldea', 'Uldaman'
  end
  
  it "should have a name" do
    @fyrbard.name.should == 'Fyrbard'
    @aldea.name.should == 'Aldea'
  end
  
  it "should have a realm" do
    @fyrbard.realm.should == 'Uldaman'
    @aldea.realm.should == 'Uldaman'
  end
  
  it "should have a region" do
    @fyrbard.region.should == :us
    @aldea.region.should == :us
  end
  
  it "should have a armory object" do
    @fyrbard.armory.should_not be_nil
    @aldea.armory.should_not be_nil
  end
  
  it "should have an xml sheet" do
    @fyrbard.sheet.should_not be_nil
    @aldea.sheet.should_not be_nil
  end
  
  it "should have a class" do
  end
  
  it "should have a level" do
  end
end
