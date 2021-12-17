require './merge_sort'

describe MergeSort do
  describe '#sort' do
    it 'sorts an empty array' do
      expect(subject.sort([])).to eql([])
    end

    it 'sorts an array with a single element' do
      expect(subject.sort([1])).to eql([1])
    end

    it 'sorts an array with two elements' do
      array = [2, 1]
      sorted_array = [1, 2]
      expect(subject.sort(array)).to eql(sorted_array)
    end
  end
end
