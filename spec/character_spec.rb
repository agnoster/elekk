require 'elekk'
include Elekk

describe Character do
  before :each do
    @armory = Armory.new 'Uldaman', :us
    @fyrbard = @armory.character 'Fyrbard'
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
  
  it "should have the right class" do
    @fyrbard.klass.should == Klass::Priest
    @aldea.klass.should == Klass::Warrior
    @armory.character('Ultimohombre').klass.should == Klass::DeathKnight
  end
  
  it "should have the right level" do
    @fyrbard.level.should == 80
    @armory.character('Harimad').level.should == 16
  end
  
  it "should have the right faction" do
    @fyrbard.faction.should == Faction::Alliance
    @armory.character('Tabularasa').faction.should == Faction::Horde
  end
  
  it "should have the right race" do
    @fyrbard.race.should == Race::Dwarf
    @aldea.race.should == Race::Human
    @armory.character('Alassiel').race.should == Race::NightElf
    @armory.character('Wulffe').race.should == Race::Draenei
  end
  
  it "should have the right gender" do
    @fyrbard.gender.should == Gender::Male
    @aldea.gender.should == Gender::Female
  end
  
  it "should have the right specs" do
    @fyrbard.spec(0).should == TalentTree::Priest::Shadow
    @fyrbard.spec(1).should == TalentTree::Priest::Holy
    @aldea.spec(:active).should == TalentTree::Warrior::Protection
    @armory.character('Alassiel').spec(0).should == TalentTree::Hunter::BeastMastery
    @armory.character('Alassiel').spec(0).name.should == 'Beast Mastery'
    @armory.character('Ultimohombre').spec(0).should == TalentTree::DeathKnight::Frost
  end
  
  it "should have the right points" do
    @fyrbard.points.should >= 4000
    @fyrbard.points.should <= 5000
  end
  
  it "should have the right title" do
    @fyrbard.fullname.should == 'Fyrbard Jenkins'
    @aldea.fullname.should == 'Aldea of the Nightfall'
    @aldea.fullname(:strong).should == '<strong>Aldea</strong> of the Nightfall'
    @fyrbard.fullname('').should == 'Fyrbard Jenkins'
    @armory.character('Bitterleaf').fullname('strong').should == 'Loremaster <strong>Bitterleaf</strong>'
  end
  
  it "should generate the right image" do
    @fyrbard.portrait.should == 'http://us.wowarmory.com/_images/portraits/wow-80/0-3-5.gif';
    @aldea.portrait.should == 'http://us.wowarmory.com/_images/portraits/wow-80/1-1-1.gif';
    @armory.character('Harimad').portrait.should == 'http://us.wowarmory.com/_images/portraits/wow-default/1-3-1.gif';
  end

end
