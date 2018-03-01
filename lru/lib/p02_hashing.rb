class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, idx|
      # if el.class == Symbol
      #   sum+=(el.to_s.ord*idx)*93123
      if el.class == String
        sum+=(el.ord*idx)*9312
      else
        sum+=(el*idx)*9312
      end
    end

    (sum % 919191).hash
  end
end

class String
  def hash
    self.chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    combined_arr = []

    if self.keys != []
      self.keys.each do |key|
        if key.class == Symbol
          combined_arr.push(key.to_s)
        else
          combined_arr.push(key)
        end
      end
    else
      combined_arr.push([].hash)
    end

    if self.values != []
      self.values.each do |val|
        if val.class == Symbol
          combined_arr.push(val.to_s)
        else
          combined_arr.push(val)
        end
      end
    else
      combined_arr.push([].hash)
    end

    combined_arr.sort.hash % 919191
  end
end
