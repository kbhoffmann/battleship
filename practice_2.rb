a = [1, 1, 2]



def unique_val_test?(coordinates)
  coordinates.tally(&:uniq).count == 1
end

p unique_val_test?(a)
