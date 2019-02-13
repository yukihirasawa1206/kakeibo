require 'rails_helper'

RSpec.describe AccountData, :type => :model do

  before do
    @account_data = FactoryBot.build(:account_data)
  end

  describe "validation of presence" do

    it "should be valid factory." do
      expect(@account_data).to be_valid
    end

    it "should be invalid data without category_id"do
      @account_data.category_id = ""
      @account_data.valid?
      expect(@account_data.errors[:category_id]).to include("can't be blank")
    end

    it "should be invalid data without category_id"do
      @account_data.category_id = ""
      @account_data.valid?
      expect(@account_data.errors[:category_id]).to include("can't be blank")
    end

    it "should be invalid data without genre_id"do
      @account_data.genre_id = ""
      @account_data.valid?
      expect(@account_data.errors[:genre_id]).to include("can't be blank")
    end

    it "should be invalid data without amount"do
      @account_data.amount = ""
      @account_data.valid?
      expect(@account_data.errors[:amount]).to include("can't be blank")
    end

    it "should be invalid data without date"do
      @account_data.date = ""
      @account_data.valid?
      expect(@account_data.errors[:date]).to include("can't be blank")
    end

  end

  describe "validates of length" do

    it "should be valid data if a name is less than or equal to 100 characters" do
      @account_data.name = "a" * 100
      expect(@account_data).to be_valid
    end

    it "should be invalid data if a name is more than 100 characters" do
      @account_data.name = "a" * 101
      @account_data.valid?
      expect(@account_data.errors[:name]).to include("is too long (maximum is 100 characters)")
    end

    it "should be valid data if a comment is less than or equal to 100 characters" do
      @account_data.comment = "a" * 100
      expect(@account_data).to be_valid
    end

    it "should be invalid data if a comment is more than 100 characters" do
      @account_data.comment = "a" * 101
      @account_data.valid?
      expect(@account_data.errors[:comment]).to include("is too long (maximum is 100 characters)")
    end

    it "should be valid data if a place is less than or equal to 100 characters" do
      @account_data.place = "a" * 100
      expect(@account_data).to be_valid
    end

    it "should be invalid data if a place is more than 100 characters" do
      @account_data.place = "a" * 101
      @account_data.valid?
      expect(@account_data.errors[:place]).to include("is too long (maximum is 100 characters)")
    end
  end

end
