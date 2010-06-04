require 'elekk'
include Elekk

describe Armory do
  before :each do
    @armory = Armory.new 'Uldaman'
  end
  
  it "should have a default region" do
    @armory.region.should == :us
  end
  
  it "should have a region, even when freshly instantiated" do
    a = Armory.new
    a.region.should_not be_nil
  end
  
  it "should have a default realm" do
    @armory.realm.should == 'Uldaman'
  end
  
  it "should allow looking up of a Character" do
    character = @armory.character 'Fyrbard'
    character.should_not be_nil
    character.name.should == 'Fyrbard'
    character.armory.should == @armory
  end
  
  it "should know the proper server to request from" do
    @armory.base.should == 'http://us.wowarmory.com/'
    eu_armory = Armory.new :region => :eu
    eu_armory.base.should == 'http://eu.wowarmory.com/'
  end
  
  it "should build URLs relative to the server" do
    @armory.url('character-sheet.xml').should == 'http://us.wowarmory.com/character-sheet.xml';
  end
  
  it "should retrieve data from the armory" do
    response = @armory.get_url 'character-sheet.xml', :r => 'Uldaman', :cn => 'Fyrbard'
    response.should_not be_nil
    response.body.should_not be_nil
    response.body.should_not be_empty
  end
  
  it "should get xml from the armory" do
    xml = @armory.get_xml 'character-sheet', :r => 'Uldaman', :cn => 'Fyrbard'
    xml.should_not be_nil
  end
  
end