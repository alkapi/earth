require 'earth'

module Earth
  module EIA
    extend self
    
    def convert_value(value, args = {})
      case value
      when '*'
        0
      when 'Q', 'W'
        nil
      else
        if args[:to]
          value.to_f.send(args[:from]).to(args[:to])
        else
          value.to_f
        end
      end
    end
  end
end
