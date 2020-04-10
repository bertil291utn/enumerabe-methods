# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

# method start
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    index = 0
    while index < size
      yield(self[index])
      index += 1
    end
  end

  def my_each_with_index
    return to_enum :my_each unless block_given?

    index = 0
    while index < size
      elem = self[index]
      yield(elem, index)
      index += 1
    end
  end

  def my_select
    return to_enum :my_each unless block_given?

    var_seleccionado = []
    my_each { |elem| var_seleccionado.push(elem) if yield(elem) }
    var_seleccionado
  end

  def my_all?(argument = nil)
    if argument.nil? && !block_given?
      my_each { |elem| return false if elem.nil? || !elem }
    elsif argument.nil?
      my_each { |elem| return false unless yield(elem) }
    elsif argument.is_a? Regexp
      my_each { |elem| return false unless elem.match(argument) }
    elsif argument.is_a? Module
      my_each { |elem| return false unless elem.is_a?(argument) }
    else
      my_each { |elem| return false unless elem == argument }
    end
    true
  end

  def my_any?(argument = nil)
    if argument.nil? && !block_given?
      my_each { |elem| return true unless elem.nil? || !elem }
    elsif argument.nil?
      my_each { |elem| return true if yield(elem) }
    elsif argument.is_a? Regexp
      my_each { |elem| return true if elem.match(argument) }
    elsif argument.is_a? Module
      my_each { |elem| return true if elem.is_a?(argument) }
    else
      my_each { |elem| return true if elem == argument }
    end
    false
  end

  def my_none?(argument = nil)
    if argument.nil? && !block_given?
      my_each { |elem| return false if elem }
    elsif argument.nil?
      my_each { |elem| return false if yield(elem) }
    elsif argument.is_a? Regexp
      my_each { |elem| return false if elem.match(argument) }
    elsif argument.is_a? Module
      my_each { |elem| return false if elem.is_a?(argument) }
    else
      my_each { |elem| return false if elem == argument }
    end
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
    return to_enum :my_map unless block_given?

    returned_array = []
    my_each do |elem|
      returned_array.push((procedure ? procedure.call(elem) : yield(elem)))
    end
    returned_array
  end

  def my_inject(*argument)
    array = is_a?(Array) ? self : to_a
    inicio = argument[0] if argument[0].is_a?(Integer)
    es_simbolo = argument[0] if argument[0].is_a?(Symbol)
    resultado = inicio
    if es_simbolo
      array.my_each do |elem|
        resultado = resultado ? resultado.send(es_simbolo, elem) : elem
      end
    else
      array.my_each do |elem|
        resultado = resultado ? yield(resultado, elem) : elem
      end
    end
    resultado
  end
end

# end module

def multiply_els(arr, num_inicial = nil)
  total = arr.my_inject(num_inicial) { |elem, siguiente| elem * siguiente }
  total
end

# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
