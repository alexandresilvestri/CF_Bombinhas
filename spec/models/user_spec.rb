require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(email: 'test@example.com', password: 'pass123!') }

  describe 'Devise modules' do
    it 'is database authenticatable' do
      expect(user).to respond_to(:email, :encrypted_password)
    end

    it 'is registerable' do
      expect(described_class.devise_modules).to include(:registerable)
    end

    it 'is recoverable' do
      expect(user).to respond_to(:reset_password_token, :reset_password_sent_at)
    end

    it 'is rememberable' do
      expect(user).to respond_to(:remember_created_at)
    end

    it 'is invitable' do
      expect(user).to respond_to(:invitation_token, :invitation_sent_at)
    end
  end

  describe 'validations' do
    it 'is valid with a valid email and password' do
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is invalid without a password' do
      new_user = described_class.new(email: 'nopass@example.com', password: nil)
      expect(new_user).not_to be_valid
    end

    it 'is invalid with a duplicate email' do
      described_class.create!(email: 'test@example.com', password: 'pass123@')
      expect(user).not_to be_valid
    end

    # Here i need to add my own validations
  end

  describe 'attributes' do
    it 'has a first_name' do
      user.first_name = 'Josimar'
      expect(user.first_name).to eq('Josimar')
    end

    it 'has a last_name' do
      user.last_name = 'Vieira'
      expect(user.last_name).to eq('Vieira')
    end

    it 'has an is_admin flag' do
      user.is_admin = true
      expect(user.is_admin).to be true
    end

    it 'has an is_coach flag' do
      user.is_coach = true
      expect(user.is_coach).to be true
    end
  end

  # TODO: Understanding what is:
  # associations
  # scopes
  # instance methods
end
