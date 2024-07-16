def fibs(count)
  sequence = [0, 1]
  return sequence[...count] if count <= 2

  (count - 2).times do
    sequence.push(sequence[-1] + sequence[-2])
  end

  sequence
end

def fibs_rec(count)
  return [0, 1][...count] if count <= 2

  sequence = fibs_rec(count - 1)
  sequence.push(sequence[-1] + sequence[-2])
  sequence
end

p fibs(8)
p fibs_rec(8)
