require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { described_class }

  let(:admin) { create(:user, :admin) }
  let(:non_admin) { create(:user) }
  let(:category) { create(:category) }

  permissions :create?, :update?, :destroy? do
    it 'allows admin to create, update, and destroy categories' do
      expect(subject).to permit(admin, category)
    end

    it 'denies non-admin to create, update, and destroy categories' do
      expect(subject).not_to permit(non_admin, category)
    end
  end
end
