require "rails_helper.rb"

describe User do

  before do 
    @attr = {
      :email => "example@example.com",
      :password => "123123123",
      :password_confirmation => "123123123"
    }
  end

  it "should a create a new user with valid attributes" do
    User.create!(@attr)
  end

  it "should have projects associations" do
    user = User.create!(@attr)
    expect(user).to respond_to(:projects)
  end

  describe "email" do

    it "should require valid email address" do
      user = User.new(:email => nil)
      expect(user).not_to be_valid
    end

    it "email should be valid" do
      email = "example@example.com"
      user = User.new(@attr.merge(:email => email))
      expect(user).to be_valid
    end

    it "should reject invalid email" do
      email = "example.example"
      user = User.new(@attr.merge(:email => email))
      expect(user).not_to be_valid
    end

    it "should reject duplicate emails" do
      User.create!(@attr)
      user = User.new(@attr)
      expect(user).not_to be_valid
    end
  end

  describe "password" do

    it "should require password" do
      user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
      expect(user).not_to be_valid
    end

    it "should reject short password" do
      short = "a" * 1
      user = User.new(@attr.merge(:password => short, :password_confirmation => short))
      expect(user).not_to be_valid
    end
  end
end