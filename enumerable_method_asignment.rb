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

  def my_map(procedure = nil)
    returned_array = []
    my_each do |elem|
      returned_array.push((procedure ? procedure.call(elem) : yield(elem)))
    end
    returned_array
  end

  def my_inject(inicio = nil)
    if inicio.nil?
      resultado = self[0]
      index = 1
    else
      resultado = inicio
      index = 0
    end

    self[index..-1].my_each { |elem| resultado = yield(resultado, elem) }
    resultado
  end
end

# end module

def multiply_els(arr, start = nil)
  total = arr.my_inject(start) { |elem, siguiente| elem * siguiente }
  total
end

# rubocop:disable Style/CaseEquality
