# rubocop:disable Style/CaseEquality

# method start
module Enumerable
  def my_each
    index = 0
    while index < size
      yield(self[index])
      index += 1
    end
  end

  def my_each_with_index
    index = 0
    while index < size
      elem = self[index]
      yield(elem, index)
      index += 1
    end
  end
end

# end module

# rubocop:disable Style/CaseEquality
