def fibs n
  fib_sequence = [0, 1]
  (n - 2).times do   # n - 2 cuz [0, 1] are already present in iteration
    fib_sequence << fib_sequence[-1] + fib_sequence[-2]
  end
  fib_sequence[0, n]
end

p fibs(8) #=> [0, 1, 1, 2, 3, 5, 8, 13]

def fibs_rec(n, sequence = [])
  return sequence if n == 0

  sequence << (sequence.empty? ? 0 : sequence.length == 1 ? 1 : sequence[-1] + sequence[-2])
  fibs_rec(n - 1, sequence)
end

p fibs_rec(8)  #=> [0, 1, 1, 2, 3, 5, 8, 13]