require 'spec_helper'

describe 'Hash of Hash (HoH)' do
  describe 'Can be constructed from provided PORTION_* constants when' do
    describe 'naming_system method' do
      it 'returns a Hash' do
        expect(naming_system).to be_a(Hash)
      end

      describe 'returns a giant HoH built from the PORTION_* constants that allows' do
        it 'its third sub_category to have the label "Order"' do
          starting_node = naming_system
          expect(starting_node[:sub_category][:sub_category][:sub_category][:label]).to eq("Order")
        end

        it 'its fifth sub_category to have the label "Order"' do
          starting_node = naming_system
          expect(starting_node[:sub_category][:sub_category][:sub_category][:sub_category][:sub_category][:label]).to eq("Genus")
        end

        it 'its seventh sub_category to have the label "Species"' do
          starting_node = naming_system
          expect(starting_node[:sub_category][:sub_category][:sub_category][:sub_category][:sub_category][:sub_category][:label]).to eq("Species")
        end
      end
    end
  end
end
