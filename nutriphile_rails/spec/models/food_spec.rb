require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'edge cases' do
    context 'food id does not exist in database' do
      it 'raises an exception RecordNotFound' do
        expect{Food.find(90000)}.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
    context 'food id is null' do
      it 'raises an exception RecordNotFound' do
        expect{Food.find()}.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
