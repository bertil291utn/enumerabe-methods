require './enumerable_method_asignment'

describe Enumerable do
  context 'my_each method' do
    let(:array_var) { [10, 2, 3, 4, 1, 5] }
    it 'is returning same array as original one' do
      result = []
      array_var.my_each { |elem| result.push(elem) }
      expect(array_var).to eql(result)
    end
  end
end
