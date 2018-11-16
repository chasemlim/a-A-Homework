require 'rails_helper'

RSpec.describe User, type: :model do

  u = User.new(email: "a@b.com", password: "password")

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "#is_password?" do
    ip = u.is_password?("password")
    context 'password_digest should equal password' do
      it {ip.should equal(true)}
    end
  end

  describe "#reset_session_token!" do
    old = u.session_token
    new = u.reset_session_token!

    it "resets the session token" do
      expect(old).to_not eq(new)
    end
  end

  describe "::find_by_credentials" do
    k = User.first
    credtest = User.find_by_credentials(k.email, "password")

    it "searches by email and password" do
      expect(credtest).to eq(k)
    end
  end

end
