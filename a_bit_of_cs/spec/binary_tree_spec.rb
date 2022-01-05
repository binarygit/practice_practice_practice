require './binary_tree/binary_tree'

describe Tree do
  context 'when arr size is one' do
    let(:tree) { tree = described_class.new([1]) }
    describe 'build' do
      it 'builds tree with a single node' do
        tree.build
        expect(tree.root.value).to eql(1)
      end

      it 'returns root' do
        tree.build
        expect(tree.root.value).to eql(1)
      end

      it 'builds a tree with no succ nodes' do
        tree.build
        expect(tree.root.left).to be_nil
        expect(tree.root.right).to be_nil
      end

      describe 'balanced?' do
        it 'returns true when root is leaf' do
          tree.build
          expect(tree.balanced?).to be true
        end
      end
    end
  end

  context 'when arr size is five' do
    let(:tree) do
      tree = described_class.new(Array.new(5) { |i| i + 1 })
      tree.build
      tree
    end

    describe '#build' do
      it 'returns root' do
        expect(tree.root.value).to eql(3)
      end

      it 'creates leaf nodes with no succ nodes' do
        # left nodes
        expect(tree.root.left.left.right).to be_nil
        expect(tree.root.left.left.left).to be_nil
        # right nodes
        expect(tree.root.right.left.left).to be_nil
        expect(tree.root.right.left.left).to be_nil
      end

      it 'only builds valid succ nodes' do
        # left node at lvl 1
        expect(tree.root.left.left.value).to eql(1)
        expect(tree.root.left.right).to be_nil
        # right node at lvl 1
        expect(tree.root.right.left.value).to eql(4)
        expect(tree.root.right.right).to be_nil
      end

      it 'builds a complete balanced tree' do
        # root node
        expect(tree.root.value).to eql(3)
        # nodes at lvl 1
        expect(tree.root.left.value).to eql(2)
        expect(tree.root.right.value).to eql(5)
        # nodes at lvl 2
        expect(tree.root.left.left.value).to eql(1)
        expect(tree.root.left.right).to be_nil
        expect(tree.root.right.left.value).to eql(4)
        expect(tree.root.right.right).to be_nil
      end
    end

    describe '#level_order' do
      it 'yields each node to the block' do
        arr = []
        tree.level_order { |node| arr << node.value }
        expect(arr).to eql([3, 2, 5, 1, 4])
      end

      it 'returns array with values' do
        expect(tree.level_order).to eql([3, 2, 5, 1, 4])
      end
    end

    describe '#inorder' do
      context 'when block is given' do
        it 'yields each node to the block' do
          arr = []
          tree.inorder { |node| arr << node.value }
          expect(arr).to eql([1, 2, 3, 4, 5])
        end
      end

      context 'when no block is given' do
        it 'returns an array with values' do
          expect(tree.inorder).to eql([1, 2, 3, 4, 5])
        end
      end
    end

    describe '#preorder' do
      context 'when block is given' do
        it 'yields each node to the block' do
          arr = []
          tree.preorder { |node| arr << node.value }
          expect(arr).to eql([3, 2, 1, 5, 4])
        end
      end

      context 'when no block is given' do
        it 'returns an array with values' do
          expect(tree.preorder).to eql([3, 2, 1, 5, 4])
        end
      end
    end

    describe '#postorder' do
      context 'when block is given' do
        it 'yields each node to the block' do
          arr = []
          tree.postorder { |node| arr << node.value }
          expect(arr).to eql([1, 2, 4, 5, 3])
        end
      end

      context 'when no block is given' do
        it 'returns an array with values' do
          expect(tree.postorder).to eql([1, 2, 4, 5, 3])
        end
      end
    end

    describe '#find' do
      context 'when valid value is given' do
        it 'returns node with value' do
          expect(tree.find(3)).to eql(tree.root)
        end
      end

      context 'when invalid value is given' do
        it 'returns nil' do
          expect(tree.find(8)).to be_nil
        end
      end
    end

    describe '#insert' do
      it 'returns tree with inserted node' do
        expect(tree.find(6)).to be_nil
        tree.insert(6)
        expect(tree.find(6).value).to eql(6)
      end
    end

    describe '#delete' do
      context 'when non existing value is given' do
        it 'returns nil' do
          expect(tree.delete(6)).to be_nil
        end
      end

      context 'when existing value is given' do
        context 'when leaf node is given' do
          it 'returns tree without deleted node' do
            expect(tree.find(4).value).to eql(4)
            tree.delete(4)
            expect(tree.find(4)).to be_nil
          end
        end

        context 'when node with single child is given' do
          it 'returns tree without deleted node' do
            expect(tree.find(2).value).to eql(2)
            tree.delete(2)
            expect(tree.find(2)).to be_nil
            expect(tree.root.left.value).to eql(1)
          end
        end

        context 'when node with two children is given' do
          it 'returns tree without deleted node' do
            tree.insert(6)
            expect(tree.find(5).value).to eql(5)
            tree.delete(5)
            expect(tree.find(5)).to be_nil
            expect(tree.find(6).left.value).to eql(4)
          end

          it 'deletes root' do
            expect(tree.root.value).to eql(3)
            tree.delete(3)
            expect(tree.root.value).to eql(4)
          end
        end
      end
    end

    describe '#depth' do
      it 'return 0 for root' do
        expect(tree.depth(tree.root)).to eql(0)
      end

      it "return 1 for root's child" do
        expect(tree.depth(tree.root.left)).to eql(1)
      end

      it "return 3 for leaf node" do
        tree.insert(6)
        tree.insert(7)
        expect(tree.depth(tree.root.right.right.right)).to eql(3)
      end
    end

    describe '#balanced?' do
      context 'when tree is balanced' do
        it 'returns true' do
          expect(tree.balanced?).to be true
        end
      end

      context 'when tree is unbalanced' do
        it 'returns false' do
          tree.insert(6)
          tree.insert(7)
          tree.insert(8)
          expect(tree.balanced?).to be false
        end
      end
    end
  end

  context 'when arr size is 100' do
    let(:tree) do
      tree = described_class.new(Array.new(100) { |i| i + 1 })
      tree.build
      tree
    end

    describe '#root' do
      it 'returns correct root' do
        expect(tree.root.value).to eql(51)
      end
    end

    describe '#inorder' do
      it 'returns tree elements in sorted order' do
        expect(tree.inorder).to eql(Array.new(100) { |i| i + 1 })
      end
    end

    describe '#preorder' do
      it 'returns root as first element' do
        expect(tree.preorder[0]).to eql(51)
      end
    end

    describe '#postorder' do
      it 'returns root as last element' do
        expect(tree.postorder[-1]).to eql(51)
      end
    end

    describe '#depth' do
      it 'returns 0 for root node' do
        expect(tree.depth(tree.root)).to eql(0)
      end

      it 'returns 1 for root child' do
        expect(tree.depth(tree.root.left)).to eql(1)
      end

      it "returns 3 for root child's grandchildren" do
        expect(tree.depth(tree.root.left.right.right)).to eql(3)
      end
    end

    describe '#balanced?' do
      context 'when tree is balanced' do
        it 'returns true' do
          expect(tree.balanced?).to be true
        end
      end

      context 'when tree is unbalanced' do
        it 'returns false' do
          tree.insert(101)
          tree.insert(102)
          tree.insert(103)
          expect(tree.balanced?).to be false
        end
      end
    end

    describe '#rebalance' do
      context 'when tree is balanced' do
        it 'returns tree' do
          expect(tree.rebalance).to equal(tree)
        end

        it 'returns tree' do
          tree.insert(103)
          expect(tree.rebalance).to equal(tree)
        end
      end

      context 'when tree is unbalanced' do
        it 'returns balanced tree' do
          expect(tree.balanced?).to be true
          tree.insert(101)
          tree.insert(102)
          tree.insert(103)
          expect(tree.balanced?).to be false
          tree.rebalance
          expect(tree.balanced?).to be true
        end
      end
    end
  end
end
