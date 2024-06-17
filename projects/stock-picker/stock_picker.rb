def stock_picker(prices)
  most_profitable_days = [0, 0]

  for i in (0...prices.length)
    for j in (i...prices.length)
      if prices[j] - prices[i] > prices[most_profitable_days[1]] - prices[most_profitable_days[0]]
        most_profitable_days = [i, j]
      end
    end
  end

  most_profitable_days
end

p stock_picker([17,3,6,9,15,8,6,1,10])
