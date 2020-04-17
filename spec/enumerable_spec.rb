require './enumerable_method_asignment'

describe Enumerable do
  let(:array_numbers) { [10, 2, 3, 4, 1, 5] }
  let(:array_string) { %w[10 2 3 4 1 5] }
  let(:range) { (1..20) }

  describe 'my_each method' do
    context 'numbers array ' do
      it 'is returning same array as original number one' do
        result = []
        array_numbers.my_each { |elem| result.push(elem) }
        expect(array_numbers).to eql(result)
      end
    end

    context 'string array' do
      it 'is returning same array as original string one' do
        result = []
        array_string.my_each { |elem| result.push(elem) }
        expect(array_string).to eql(result)
      end
    end
  end
end
