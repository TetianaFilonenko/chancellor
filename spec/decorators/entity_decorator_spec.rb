require 'rails_helper'

RSpec.describe EntityDecorator, :type => :decorator do
  subject(:decorator) { entity.decorate }

  context 'when all address lines are present' do
    let(:entity) { create(:entity) }

    its(:display_string) do
      is_expected.to eq("#{entity.reference} - #{entity.name}")
    end

    its(:long_name) do
      is_expected.to eq("#{entity.reference} - #{entity.name}")
    end
  end
end
