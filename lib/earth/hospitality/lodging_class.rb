class LodgingClass < ActiveRecord::Base
  self.primary_key = "name"
  
  col :name

  warn_unless_size 3
end
