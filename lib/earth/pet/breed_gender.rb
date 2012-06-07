class BreedGender < ActiveRecord::Base
  self.primary_key = "name"
  
  belongs_to :breed, :foreign_key => 'breed_name'
  belongs_to :gender, :foreign_key => 'gender_name'
  
  col :name
  col :breed_name
  col :gender_name
  col :weight, :type => :float
  col :weight_units

  warn_unless_size 586
end
