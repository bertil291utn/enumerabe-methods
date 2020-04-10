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

  def my_select
    var_seleccionado = []
    my_each { |elem| var_seleccionado.push(elem) if yield(elem) }
    var_seleccionado
  end

  def my_all?
    if !block_given?
      my_each { |elem| return false if elem.nil? || !elem }
    else
      my_each { |elem| return false unless yield(elem) }
    end
    true
  end

  def my_any?
    if !block_given?
      my_each { |elem| return true unless elem.nil? || !elem }
    else
      my_each { |elem| return true if yield(elem) }
    end
    false
  end

  def my_none?
    my_each { |elem| return false if yield(elem) }
    true
  end

  def my_count(arguments = nil)
    return length if !block_given? && arguments.nil?

    count = 0
    my_each do |elem|
      if arguments
        count += 1 if elem == arguments
      elsif yield(elem)
        count += 1
      end
    end
    count
  end
end

# end module

# rubocop:disable Style/CaseEquality
