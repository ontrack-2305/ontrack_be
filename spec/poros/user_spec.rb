require "rails_helper"

RSpec.describe User do
  it "exists" do
    user = User.new({
      user_id: 1, 
      google_id: 123, 
      access_token: 234567, 
      email: "example@test.com"
      })

    expect(user).to be_a(User)
    expect(user.id).to eq(1)
    expect(user.google_id).to eq(123)
    expect(user.token).to eq(234567)
    expect(user.email).to eq("example@test.com")
  end
end