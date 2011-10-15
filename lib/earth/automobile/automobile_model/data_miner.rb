AutomobileModel.class_eval do
  data_miner do
    process "Ensure AutomobileMakeModelYearVariant is populated" do
      AutomobileMakeModelYearVariant.run_data_miner!
    end
    
    process "Derive model names from automobile make model year variants" do
      ::Earth::Utils.insert_ignore(
        :src => AutomobileMakeModelYearVariant,
        :dest => AutomobileModel,
        :cols => { :model_name => :name }
      )
    end
  end
end
