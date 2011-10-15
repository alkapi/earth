Urbanity.class_eval do
  data_miner do
    process "Ensure ResidentialEnergyConsumptionSurveyResponse is populated" do
      ResidentialEnergyConsumptionSurveyResponse.run_data_miner!
    end
    
    process "Derive from ResidentialEnergyConsumptionSurveyResponse" do
      ::Earth::Utils.insert_ignore(
        :src => ResidentialEnergyConsumptionSurveyResponse,
        :dest => Urbanity,
        :cols => { :urbanity_id => :name }
      )
    end
  end
end
