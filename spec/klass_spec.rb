require 'elekk'
include Elekk

describe Klass do
  it "should be properly indexed" do
    dk = Klass.new "Death Knight", 11
    dk.name.should == 'Death Knight'
    dk.id.should == 11
    dk.to_sym.should == :DeathKnight
  end
  
  it "should be findable as a constant" do
    Klass::Priest.should_not be_nil
    Klass::DeathKnight.should_not be_nil
  end
  
  it "should have a name" do
    Klass::Priest.name.should == 'Priest'
  end
  
  it "should preserve spaces in name" do
    Klass::DeathKnight.name.should == 'Death Knight'
  end
  
  it "should be indexable by ints, strings and symbols" do
    dk = Klass::DeathKnight
    Klass[6].should == dk
    Klass['Death Knight'].should == dk
    Klass[:DeathKnight].should == dk
  end
  
  it "should be convertible to an int" do
    Klass::Priest.to_i.should == 5
  end
  it "should be convertible to a symbol" do
    Klass::Priest.to_sym.should == :Priest
  end
  
  it "should be convertible to a string" do
    Klass::Priest.to_s.should == 'Priest'
  end
  
end