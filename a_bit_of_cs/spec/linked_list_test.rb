require './linked_list/main'

describe LinkedList do
  context 'when list is empty' do
    describe '#append' do
      it 'creates head' do
        appended = subject.append('Hello World')
        expect(subject.head).to be(appended)
      end

      it 'creates tail' do
        appended = subject.append('Hello World')
        expect(subject.tail).to be(appended)
      end

      it 'returns appended node' do
        appended = subject.append('Hello World')
        expect(appended.value).to eq('Hello World')
      end
    end

    describe '#prepend' do
      it 'creates head' do
        prepended = subject.prepend('Hello World')
        expect(subject.head).to be(prepended)
      end

      it 'creates tail' do
        prepended = subject.prepend('Hello World')
        expect(subject.tail).to be(prepended)
      end

      it 'returns prepended node' do
        prepended = subject.prepend('Hello World')
        expect(prepended.value).to eq('Hello World')
      end
    end

    describe '#size' do
      it 'returns 0' do
        expect(subject.size).to eql(0)
      end
    end

    describe '#head' do
      it 'returns nil' do
        expect(subject.head).to be_nil
      end
    end

    describe '#tail' do
      it 'returns nil' do
        expect(subject.tail).to be_nil
      end
    end

    describe '#at' do
      it 'returns nil' do
        expect(subject.at(3)).to be_nil
      end
    end

    describe '#pop' do
      it 'returns nil' do
        expect(subject.pop).to be_nil
      end
    end

    describe '#to_s' do
      it 'returns message if no nodes in list' do
        expect(subject.to_s).to eql('No items in list')
      end
    end

    describe '#insert_at' do
      context 'when index is valid' do
        it 'inserts node at head' do
          node = subject.insert_at(0, 'a')
          expect(subject.head).to be(node)
        end

        it 'inserts node at tail' do
          node = subject.insert_at(0, 'a')
          expect(subject.tail).to be(node)
        end
      end

      context 'when index is invalid' do
        it 'returns nil' do
          expect(subject.insert_at(-1, 'a')).to be_nil
        end

        it 'returns nil' do
          expect(subject.insert_at(1, 'a')).to be_nil
        end
      end
    end

    describe '#remove_at' do
      it 'returns nil' do
        expect(subject.remove_at(-4)).to be_nil
      end

      it 'returns nil' do
        expect(subject.remove_at(8)).to be_nil
      end
    end
  end

  context 'when list is not empty' do
    let(:populated_list) do
      list = described_class.new
      list.append(1)
      list.append(2)
      list.append(3)
      list.append(4)
      list.append(5)
      list
    end

    describe '#append' do
      it 'appends to the end of the list' do
        appended = populated_list.append('Hello World!')
        expect(populated_list.tail).to be(appended)
      end

      it 'returns appended node' do
        appended = populated_list.append('Hello World!')
        expect(appended.value).to eql('Hello World!')
      end
    end

    describe '#prepend' do
      it 'prepends to the start of the list' do
        prepended = populated_list.prepend('Hello World! Hello World!')
        expect(populated_list.head).to be(prepended)
      end

      it 'returns prepended node' do
        prepended = populated_list.prepend('Hello World! Hello World!')
        expect(prepended.value).to eql('Hello World! Hello World!')
      end
    end

    describe '#size' do
      it 'returns number of elements in list' do
        expect(populated_list.size).to eql(5)
      end
    end

    describe '#head' do
      it 'returns head' do
        expect(populated_list.head.value).to eql(1)
      end
    end

    describe '#tail' do
      it 'returns tail' do
        expect(populated_list.tail.value).to eql(5)
      end
    end

    describe '#at' do
      context 'when index is out-of-reach' do
        it 'returns nil' do
          expect(populated_list.at(6)).to be_nil
        end
        it 'returns nil' do
          expect(populated_list.at(-6)).to be_nil
        end
      end

      context 'when index is in-reach' do
        it 'returns node at index' do
          expect(populated_list.at(0)).to be(populated_list.head)
        end

        it 'returns node at index' do
          expect(populated_list.at(1)).to be(populated_list.head.next_node)
        end
      end
    end

    describe '#pop' do
      context 'when list has a single element' do
        it 'resets head to nil' do
          subject.prepend('one')
          expect(subject.head.value).to eql('one')
          subject.pop
          expect(subject.head).to be_nil
        end

        it 'returns poped node' do
          subject.prepend('one')
          expect(subject.pop.value).to eql('one')
        end
      end

      context 'when list has multiple elements' do
        it 'sets second last node as tail' do
          populated_list.pop
          expect(populated_list.tail.value).to eql(4)
        end

        it 'returns poped node' do
          expect(populated_list.pop.value).to eql(5)
        end
      end
    end

    describe '#contains?' do
      it 'returns false if no matching value found' do
        expect(populated_list.contains?('a')).to be false
      end

      it 'returns true if matching value found' do
        expect(populated_list.contains?(1)).to be true
      end
    end

    describe '#find' do
      it 'returns nil if no value found' do
        expect(populated_list.find('a')).to be_nil
      end

      it 'returns index of node containing value' do
        expect(populated_list.find(2)).to eql(1)
      end
    end

    describe '#to_s' do
      it 'returns a prettified list' do
        expect(populated_list.to_s).to eql("( 1 ) -> ( 2 ) -> ( 3 ) -> ( 4 ) -> ( 5 ) -> nil")
      end
    end

    describe '#insert_at' do
      context 'when index is valid' do
        it 'inserts node at head' do
          populated_list.insert_at(0, 'a')
          expect(populated_list.head.value).to eql('a')
        end

        it 'inserts node at tail' do
          populated_list.insert_at(4, 'a')
          expect(populated_list.tail.value).to eql('a')
        end

        it 'inserts node in the middle' do
          populated_list.insert_at(1, 'a')
          expect(populated_list.head.next_node.value).to eql('a')
        end
      end

      context 'when index is invalid' do
        it 'returns nil' do
          expect(populated_list.insert_at(-1, 'a')).to be_nil
        end

        it 'returns nil' do
          expect(populated_list.insert_at(5, 'a')).to be_nil
        end
      end
    end

    # should return nil if invalid index
    describe '#remove_at' do
      context 'when index is valid' do
        it 'removes tail if last index' do
          populated_list.remove_at(4)
          expect(populated_list.tail.value).to eql(4)
        end

        it 'removes head if first index' do
          populated_list.remove_at(0)
          expect(populated_list.head.value).to eql(2)
        end

        it 'removes node in the middle' do
          populated_list.remove_at(1)
          expect(populated_list.head.next_node.value).to eql(3)
        end
      end

      context 'when index is invald' do
        it 'returns nil' do
          expect(populated_list.remove_at(-4)).to be_nil
        end

        it 'returns nil' do
          expect(populated_list.remove_at(8)).to be_nil
        end
      end
    end
  end

  describe '#uniq' do
    let(:dublicates_list) do
      list = described_class.new
      list.append(1)
      list.append(2)
      list.append(2)
      list.append(2)
      list.append(3)
      list.append(4)
      list.append(4)
      list.append(5)
      list
    end

    it 'removes duplicated value after single traversal' do
      expect(dublicates_list.uniq.to_s).to eql('( 1 ) -> ( 2 ) -> ( 3 ) -> ( 4 ) -> ( 5 ) -> nil')
    end
  end
end
