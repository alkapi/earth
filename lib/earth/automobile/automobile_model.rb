class AutomobileModel < ActiveRecord::Base
  TABLE_STRUCTURE = <<-EOS
CREATE TABLE "automobile_models"
  (
     "name" CHARACTER VARYING(255) NOT NULL
  );
ALTER TABLE "automobile_models" ADD PRIMARY KEY ("name")
EOS

  self.primary_key = "name"
  

  warn_unless_size 2299
end
