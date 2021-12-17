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

    it 'sorts an array with negative element' do
      array = [-2, 1, 0]
      sorted_array = [-2, 0, 1]
      expect(subject.sort(array)).to eql(sorted_array)
    end

    it 'sorts an sorted array' do
      array = [-2, 0, 1]
      sorted_array = [-2, 0, 1]
      expect(subject.sort(array)).to eql(sorted_array)
    end
    
    it 'sorts an array with 100 elements' do
      array = [76, 31, 18, 64, 70, 28, 99, 84, 93, 89, 74, 10, 4, 21, 94, 90, 61, 42, 0, 93, 91, 9, 20, 14, 50, 4, 32, 13, 93, 92, 41, 4, 36, 24, 31, 47, 47, 14, 59, 81, 0, 78, 60, 77, 44, 37, 0, 33, 0, 72, 84, 55, 45, 49, 75, 31, 1, 5, 94, 90, 87, 5, 79, 62, 62, 70, 28, 21, 15, 98, 40, 51, 97, 58, 18, 86, 17, 38, 14, 54, 85, 85, 27, 56, 44, 64, 82, 35, 89, 98, 20, 57, 15, 34, 28, 40, 1, 98, 6, 16]

      sorted_array = [0, 0, 0, 0, 1, 1, 4, 4, 4, 5, 5, 6, 9, 10, 13, 14, 14, 14, 15, 15, 16, 17, 18, 18, 20, 20, 21, 21, 24, 27, 28, 28, 28, 31, 31, 31, 32, 33, 34, 35, 36, 37, 38, 40, 40, 41, 42, 44, 44, 45, 47, 47, 49, 50, 51, 54, 55, 56, 57, 58, 59, 60, 61, 62, 62, 64, 64, 70, 70, 72, 74, 75, 76, 77, 78, 79, 81, 82, 84, 84, 85, 85, 86, 87, 89, 89, 90, 90, 91, 92, 93, 93, 93, 94, 94, 97, 98, 98, 98, 99] 

      expect(subject.sort(array)).to eql(sorted_array)
    end
  end
end
