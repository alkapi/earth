require 'earth/fuel'
class RailCompanyTraction < ActiveRecord::Base
  TABLE_STRUCTURE = <<-EOS
CREATE TABLE "rail_company_tractions"
  (
     "name"                        CHARACTER VARYING(255) NOT NULL,
     "rail_company_name"           CHARACTER VARYING(255),
     "rail_traction_name"          CHARACTER VARYING(255),
     "electricity_intensity"       FLOAT,
     "electricity_intensity_units" CHARACTER VARYING(255),
     "diesel_intensity"            FLOAT,
     "diesel_intensity_units"      CHARACTER VARYING(255),
     "co2_emission_factor"         FLOAT,
     "co2_emission_factor_units"   CHARACTER VARYING(255)
  );
ALTER TABLE "rail_company_tractions" ADD PRIMARY KEY ("name")
EOS

  self.primary_key = "name"
end
