require 'rails_helper'

RSpec.describe Diary, type: :model do
  def diary_attributes(new_attributes = {}) {
    diary_date: "2018-04-30",
    meal_type: "Breakfast",
    food_name: Food.find{rand(1..100)},
    amount: 20,
    user: user
  }.merge(new_attributes)
  end

  describe 'validations' do
    it 'requires a date' do
      d1 = Diary.new
      d1.valid?
      expect(d1.errors.messages).to have_key(:diary_date)
    end

    it 'does not require a unique date' do
      user = User.create(email: 'aasdiof23@asagfhi2.com', password: 'supersecret')
      d1 = Diary.create!(diary_date: "2018-04-30", meal_type: "Breakfast",
        food_name: Food.find{rand(1..100)}, amount: 20, user: user)
      d2 = Diary.new(diary_date: "2018-04-30", meal_type: "Breakfast",
        food_name: Food.find{rand(1..100)}, amount: 20, user: user)
      d2.valid?
      expect(d2).to be_valid
    end

    it 'stores date as date' do
      user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'a@a.com')
      d1 = Diary.create!(title:'unique title', description: 'description blah', price: 300, user: user)
      result = d1.title
      expect(result).to eq('Unique title')
    end

    it 'requires a description' do
      user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'a@a.com')
      d1 = Diary.create(title:'unique title', price: 300, user: user)
      expect(d1.errors.messages).to have_key(:description)
    end

    it 'requires a price' do
      user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'a@a.com')
      d1 = Diary.new(title:'unique title', description: 'description blah', price: 300, user: user)
      d1.price=nil
      d1.save
      expect(d1.price).to_not eq(nil) #due to built-in validation
    end

    it 'must have a price greater than 0' do
      user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'a@a.com')
      d1 = Diary.create(title:'unique title', description: 'description blah', price: 0, user: user)
      expect(d1.errors.messages).to have_key(:price)
    end

    it 'searches by title or description' do
      user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'a@a.com')
      d1 = Diary.create!(title:'unique_title1', description: 'blah blah blah blah', price: 10, user: user)
      d2 = Diary.create!(title:'unique_title2', description: 'argh argh argh argh', price: 10, user: user)
      result = Diary.search('argh').first.title
      expect(result).to eq('Unique_title2')
    end

    it 'searches by description' do
      user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com', password: 'supersecret')
      d1 = Diary.create!(title:'unique_title1', description: 'blah blah blah blah', price: 10, user: user)
      d2 = Diary.create!(title:'unique_title2', description: 'argh argh argh argh', price: 10, user: user)

      result = Diary.search('blah').size
      expect(result).to eq(1)
      result1 = Diary.search('blah').first.id
      expect(result1).to eq(d1.id)
    end

    it 'searches by title' do
      user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com', password: 'supersecret')
      d1 = Diary.create!(title:'unique_title1', description: 'blah blah blah blah', price: 10, user: user)
      d2 = Diary.create!(title:'unique_title2', description: 'argh argh argh argh', price: 10, user: user)

      result = Diary.search('unique_title1').size
      expect(result).to eq(1)
      result1 = Diary.search('unique_title1').first.id
      expect(result1).to eq(d1.id)
    end
  end

# title and price must be present
# title is unique
# sale_price is set to price by default if not present
# sale_price must be less than or equal to price
# a method called on_sale? that returns true or false whether the diary is on sale or not
  describe 'validations and others' do
    it 'requires a title and price' do
      d1 = Diary.new
      d1.price = nil
      d1.valid?
      expect(d1.errors.messages).to have_key(:title)
      expect(d1.price).to_not equal(nil) # due to validation built
    end

    it 'saves if all parameters are valid' do
      u1 = FactoryBot.create(:user)
      d1 = FactoryBot.build(:diary)
      expect(d1.save).to eq(true)
    end

    it 'does not save if missing food name' do
      u1 = FactoryBot.create(:user)
      d1 = FactoryBot.build(:diary, food_name: nil)
      d1.valid?
      expect(d1.save).to eq(false)
      #what about testing if error message should have key food_name
    end

    it 'does not save if missing meal type' do
      u1 = FactoryBot.create(:user)
      d1 = FactoryBot.build(:diary, meal_type: nil)
      expect(d1.save).to eq(false)
    end

  end
end
