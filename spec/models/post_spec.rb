require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    expect(build(:post, user: user)).to be_valid
  end

  it "is not valid without a title" do
    expect(build(:post, user: user, title: nil)).to_not be_valid
  end
end
