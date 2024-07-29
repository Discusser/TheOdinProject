class Calculator
  def add(*nums)
    nums.inject(:+)
  end

  def multiply(*nums)
    nums.inject(:*)
  end

  def subtract(*nums)
    nums.inject(:-)
  end

  def divide(*nums)
    nums.inject(:/)
  end
end
