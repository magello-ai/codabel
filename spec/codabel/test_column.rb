require 'spec_helper'

describe Codabel::Column do
  let(:column) {
    Codabel::Column.new(0..10, path, Codabel::Type::AN, {})
  }

  describe 'path_starts_with?' do
    context 'when path is a singleton' do
      let(:path) {
        :counterparty
      }

      it 'returns true when same path' do
        expect(column.path_starts_with?(:counterparty)).to eql(true)
      end

      it 'returns false when different path' do
        expect(column.path_starts_with?(:counterparties)).to eql(false)
      end

      it 'returns false when longer part path' do
        expect(column.path_starts_with?([:counterparty, :name])).to eql(false)
      end
    end

    context 'when path is an array' do
      let(:path) {
        [:counterparty, :name]
      }

      it 'returns true when same path' do
        expect(column.path_starts_with?([:counterparty, :name])).to eql(true)
      end

      it 'returns true when a prefix' do
        expect(column.path_starts_with?(:counterparty)).to eql(true)
      end

      it 'returns false when longer part path' do
        expect(column.path_starts_with?([:counterparty, :name, :foo])).to eql(false)
      end

      it 'returns false when different path' do
        expect(column.path_starts_with?([:counterparty, :lasname])).to eql(false)
      end
    end
  end
end
