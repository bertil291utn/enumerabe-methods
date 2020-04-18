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
    it 'is returning same array as original number one' do
      result = []
      array_numbers.my_each { |elem| result.push(elem) }
      expect(array_numbers).to eql(result)
    end

    it 'is returning same array as original string one' do
      result = []
      array_string.my_each { |elem| result.push(elem) }
      expect(array_string).to eql(result)
    end

    it 'is returning an enumerator value when there\'s no blocken given' do
      result = array_string.my_each
      expect(result).to be_an Enumerator
    end

    it 'returns the same array as original mix array' do
      result = []
      array_mix.my_each { |elem| result.push(elem) }
      expect(array_mix).to eql(result)
    end
  end

  describe '#my_each_with_index' do
    it 'is returning same array as original numbers one' do
      my_result = []
      result = []
      array_numbers.my_each_with_index { |elem, i| my_result.push(elem + i) }
      array_numbers.each_with_index { |elem, i| result.push(elem + i) }
      expect(my_result).to eql(result)
    end

    it 'is returning same array as original string one' do
      my_result = []
      result = []
      array_string.my_each_with_index { |elem, i| my_result.push(elem + i.to_s) }
      array_string.each_with_index { |elem, i| result.push(elem + i.to_s) }
      expect(my_result).to eql(result)
    end

    it 'is returning an enumerator value when there\'s no block given' do
      result = array_string.my_each_with_index
      expect(result).to be_an Enumerator
    end

    it 'is returning same array as original mix array' do
      result = []
      array_mix.my_each_with_index { |elem, _| result.push(elem) }
      expect(array_mix).to eql(result)
    end
  end

  describe '#my_select' do
    it 'returns an enumerator value' do
      result = array_string.my_select
      expect(result).to be_an Enumerator
    end

    it 'returns a new array with elements equal to 1' do
      expect(array_numbers.my_select { |elem| elem == 1 }).to eql([1])
    end

    it 'returns a new array with elements no equal to true' do
      expect(array_mix.my_select { |elem| elem }).not_to eql([nil, 99])
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
  end

  describe '#my_count' do
    it 'returns size array (6) due to there\'s no given block' do
      expect(array_numbers.my_count).to eql(6)
    end

    it 'returns 1 due to there\'s just one with number 10' do
      expect(array_numbers.my_count(10)).to eql(1)
    end

    it 'returns 1 due to there\'s just one with word arbol' do
      expect(array_string.my_count('arbol')).to eql(1)
    end

    it 'returns 1 due to there\'s just one element which start with letter a' do
      expect(array_string.my_count(&my_proc_string)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'returns an enumerator due to there\'s no given block' do
      expect(array_numbers.my_map).to be_an Enumerator
    end

    it 'returns same array as original with given block' do
      expect(array_numbers.my_map { |elem| elem * 10 }).to eq(array_numbers.map { |elem| elem * 10 })
    end

    it 'returns same array as original with given proc' do
      expect(array_numbers.my_map(&my_proc_map)).to eq(array_numbers.map(&my_proc_map))
    end
  end

  describe '#my_inject' do
    it 'returns all additioned elements plus two' do
      expect(array_numbers.my_inject(2, :+)).to eq(27)
    end

    it 'returns all additioned elements in the range plus two' do
      expect((1..20).my_inject(2, :+)).to eq(212)
    end

    it 'returns all additioned elements plus two with a block' do
      expect((1..20).my_inject(2) { |elem, sig| elem + sig }).to eq(212)
    end

    it 'returns all multiply elements ' do
      expect((1..5).my_inject(:*)).to eq(120)
    end

    it 'returns all multiply elements with a proc ' do
      multiply_proc = proc { |elem, sig| elem * sig }
      expect(array_numbers.my_inject(&multiply_proc)).to eq(1200)
    end
  end
end
