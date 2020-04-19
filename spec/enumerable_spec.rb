require './enumerable_method_asignment'

RSpec.describe Enumerable do
  let(:array_numbers) { [10, 2, 3, 4, 1, 5] }
  let(:array_string) { %w[10 2 3 4 1 5 arbol] }
  let(:array_mix) { [nil, true, 99] }

  # procs
  let(:my_proc_numbers) { proc { |elem| elem > 10 } }
  let(:my_proc_string) { proc { |word| word[0] == 'a' } }
  let(:my_proc_map) { proc { |elem| elem * 10 } }

  describe '#my_each' do
    it 'is returning same array as original one' do
      result = []
      array_numbers.my_each { |elem| result.push(elem) }
      expect(array_numbers).to eql(result)

      result = []
      array_string.my_each { |elem| result.push(elem) }
      expect(array_string).to eql(result)
    end

    it 'when no block is given, returns an enumerator' do
      result = array_string.my_each
      expect(result).to be_an Enumerator
    end

    it 'returns the same array as original mix array' do
      my_method = []
      original_method = []
      array_mix.my_each { |elem| my_method.push(elem) }
      array_mix.each { |elem| original_method.push(elem) }
      expect(my_method).to eql(original_method)
    end
  end

  describe '#my_each_with_index' do
    it 'is returning same array as original numbers one' do
      my_result = []
      array_numbers.my_each_with_index { |elem, i| my_result.push(elem + i) }
      expect(my_result).to eql([10, 3, 5, 7, 5, 10])
    end

    it 'is returning same array as original string one' do
      my_result = []
      original_method = []
      array_string.my_each_with_index { |elem, i| my_result.push(elem + i.to_s) }
      array_string.each_with_index { |elem, i| original_method.push(elem + i.to_s) }
      expect(my_result).to eql(original_method)
    end

    it 'when no block is given, returns an enumerator' do
      result = array_string.my_each_with_index
      expect(result).to be_an Enumerator
    end
  end

  describe '#my_select' do
    it 'when no block is given, returns an enumerator' do
      result = array_string.my_select
      expect(result).to be_an Enumerator
    end
    context 'when block given' do
      it 'returns a new array with elements equal to 1' do
        expect(array_numbers.my_select { |elem| elem == 1 }).to eql([1])
      end

      it 'returns a new array with elements no equal to true' do
        expect(array_mix.my_select { |elem| elem }).not_to eql([nil])
      end
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements in array are greater than ten' do
      expect(array_numbers.my_all?(&my_proc_numbers)).to be false
    end

    it 'returns false because all elements don\'t start with letter a' do
      expect(array_string.my_all?(&my_proc_string)).to be false
    end

    it 'returns true if there are no nil or false elements on given array' do
      expect(array_numbers.my_all?).to be true
    end

    it 'returns false if at least there are a nil or false element on given array' do
      expect(array_mix.my_all?).to be false
    end

    context 'class check' do
      it 'returns true if all elements are a String class' do
        expect(array_string.my_all? { |elem| elem.is_a?(String) }).to be_truthy
      end

      it 'returns true if all elements are a Integer class' do
        expect(array_numbers.my_all? { |elem| elem.is_a?(Integer) }).to be_truthy
      end
    end

    context 'regexp check' do
      it 'expects false because array_string it hasn\'te elements equivalent to [0-9] ' do
        expect(array_string.my_all? { |elem| /\d/.match(elem) }).to be_falsey
      end

      it 'expects true because array_string it has elements equivalent to [0-9a-zA-Z_]' do
        expect(array_string.my_all? { |elem| /\w/.match(elem) }).to be_truthy
      end
    end
  end

  describe '#my_any?' do
    it 'returns false if at least there\'s one element in array is greater than ten' do
      expect(array_numbers.my_any?(&my_proc_numbers)).to be false
    end

    it 'returns true because there\'s an element which start with letter a' do
      expect(array_string.my_any?(&my_proc_string)).to be true
    end

    it 'returns true if at least there\'s an element' do
      expect(array_numbers.my_any?).to be true
    end

    it 'returns true if there are a nil or false element on given array' do
      expect(array_mix.my_any?).to be true
    end

    context 'class check' do
      it 'returns true if just a  element is a String class' do
        expect(array_string.my_any? { |elem| elem.is_a?(String) }).to be_truthy
      end

      it 'returns true if just a element is a Integer class' do
        expect(array_numbers.my_any? { |elem| elem.is_a?(Integer) }).to be_truthy
      end
    end

    context 'regexp check' do
      it 'expects true if matches just a element equivalent to [0-9] ' do
        expect(array_string.my_any? { |elem| /\d/.match(elem) }).to be_truthy
      end

      it 'expects true  if matches just a element equivalent to [0-9a-zA-Z_]' do
        expect(array_string.my_any? { |elem| /\w/.match(elem) }).to be_truthy
      end
    end
  end

  describe '#my_none?' do
    it 'returns true beaca there\'s any element in array is greater than ten' do
      expect(array_numbers.my_none?(&my_proc_numbers)).to be true
    end

    it 'returns false because there\'s just an element which start with letter a' do
      expect(array_string.my_none?(&my_proc_string)).to be false
    end

    it 'returns false due to at least there\'s an element' do
      expect(array_numbers.my_none?).to be false
    end

    it 'returns true due to at least there are a nil or false element ' do
      expect([nil, false].my_none?).to be true
    end

    it 'returns true due to is an empty array ' do
      expect([].my_none?).to be true
    end

    context 'class check' do
      it 'returns false if none of all elements are a String class' do
        expect(array_string.my_none? { |elem| elem.is_a?(String) }).to be_falsey
      end

      it 'returns false if none of all elements are a Integer class' do
        expect(array_numbers.my_none? { |elem| elem.is_a?(Integer) }).to be_falsey
      end
    end

    context 'regexp check' do
      it 'expects false if none of all  element are equivalent to [0-9] ' do
        expect(array_string.my_none? { |elem| /\d/.match(elem) }).to be_falsey
      end

      it 'expects false if none of all  element are  equivalent to [0-9a-zA-Z_]' do
        expect(array_string.my_none? { |elem| /\w/.match(elem) }).to be_falsey
      end
    end
  end

  describe '#my_count' do
    it 'returns the number of elements in the array due to there\'s no given block' do
      expect(array_numbers.my_count).to eql(6)
    end

    it 'returns the number of elements in the array due to there\'s just one with number 10' do
      expect(array_numbers.my_count(10)).to eql(1)
    end

    it 'returns the number of elements in the array due to there\'s just one with word arbol' do
      expect(array_string.my_count('arbol')).to eql(1)
    end

    it 'returns the number of elements in the array due to there\'s just one element which start with letter a' do
      expect(array_string.my_count(&my_proc_string)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'when no block is given, returns an enumerator' do
      expect(array_numbers.my_map).to be_an Enumerator
    end
    context 'given block/proc' do
      it 'returns same array as original with given block' do
        expect(array_numbers.my_map { |elem| elem * 10 }).to eq([100, 20, 30, 40, 10, 50])
      end

      it 'returns same array as original with given proc' do
        expect(array_numbers.my_map(&my_proc_map)).to eq([100, 20, 30, 40, 10, 50])
      end
    end
  end

  describe '#my_inject' do
    it 'returns all additioned elements plus two' do
      expect(array_numbers.my_inject(2, :+)).to eq(array_numbers.inject(2, :+))
    end

    it 'returns all additioned elements in the range plus two' do
      expect((1..20).my_inject(2, :+)).to eq((1..20).inject(2, :+))
    end

    it 'returns all additioned elements plus two with a block' do
      expect((1..20).my_inject(2) { |elem, sig| elem + sig }).to eq((1..20).inject(2) { |elem, sig| elem + sig })
    end

    it 'returns all multiply elements ' do
      expect((1..5).my_inject(:*)).to eq((1..5).inject(:*))
    end

    it 'returns all multiply elements with a proc ' do
      multiply_proc = proc { |elem, sig| elem * sig }
      expect(array_numbers.my_inject(&multiply_proc)).to eq(array_numbers.inject(&multiply_proc))
    end
  end
end
