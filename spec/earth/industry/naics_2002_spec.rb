require 'spec_helper'
require 'earth/industry/naics_2002'

describe Naics2002 do
  before :all do
    Naics2002.auto_upgrade!
  end
  
  describe "when importing data", :slow => true do
    before do
      require 'earth/industry/naics_2002/data_miner'
    end
    
    it "imports all naics codes" do
      Naics2002.run_data_miner!
      Naics2002.count.should == 2341
    end
  end
  
  describe "code translations" do
    before do
      require 'earth/industry/sic_1987'
      require 'earth/industry/naics_2002_sic_1987_concordance'
    end
    
    it "can be translated to a SIC 1987 code" do
      {
        '111140' => %w{ 0111 },
        '111150' => %w{ 0115 0119 },
        '111920' => %w{ 0131 },
        '238910' => %w{ 1081 1241 1389 1481 1629 1711 1794 1795 1799 7353 },
        '488119' => %w{ 4581 4959 7997 }
      }.each do |naics, sics|
        Naics2002.find(naics).sic_1987.map(&:code).sort.should == sics
      end
    end
  end
end
