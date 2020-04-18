require './enumerable_method_asignment'

RSpec.describe Enumerable do
  let(:array_numbers) { [10, 2, 3, 4, 1, 5] }
  let(:array_string) { %w[10 2 3 4 1 5] }
  let(:array_mix) { [nil, true, 99] }
  let(:range) { (1..20) }

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

    it 'is returning same array as original mix array' do
      result = []
      array_mix.my_each { |elem| result.push(elem) }
      expect(array_mix).to eql(result)
    end
  end

  describe 'my_each_with_index method' do
    context 'numbers array ' do
      it 'is returning same array as original numbers one' do
        my_result = []
        result = []
        array_numbers.my_each_with_index { |elem, i| my_result.push(elem + i) }
        array_numbers.each_with_index { |elem, i| result.push(elem + i) }
        expect(my_result).to eql(result)
      end
    end

    context 'string array' do
      it 'is returning same array as original string one' do
        my_result = []
        result = []
        array_string.my_each_with_index { |elem, i| my_result.push(elem + i.to_s) }
        array_string.each_with_index { |elem, i| result.push(elem + i.to_s) }
        expect(my_result).to eql(result)
      end
    end

    context 'no blocken given' do
      it 'is returning an enumerator value' do
        result = array_string.my_each_with_index
        expect(result).to be_an Enumerator
      end
    end
  end

  describe 'my_select method' do
    context 'no blocken given' do
      it 'is returning an enumerator value' do
        result = array_string.my_select
        expect(result).to be_an Enumerator
      end
    end
    # check this
    context 'numbers array ' do
      it 'is returning same array as original numbers one' do
        result = []
        array_numbers.my_select { |elem| result.push(elem) }
        expect(array_numbers).to eql(result)
      end
    end
  end
end
