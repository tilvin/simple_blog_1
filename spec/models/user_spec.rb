require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    expect(build(:user)).to be_valid
  end

  it "is not valid without a email" do
    user = (build(:user, email: nil))
    expect(user).to_not be_valid
  end

  it "is not valid without if password doesnt match password_confirmation" do
    user = (build(:user, password: 'password', password_confirmation: 'wrong_password'))
    expect(user).to_not be_valid
  end
end
