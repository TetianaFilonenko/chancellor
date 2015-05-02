require 'rails_helper'

module Chancellor
  describe Disableable, :type => :model do
    describe '#active?' do
      let(:disableable) do
        instance = Class.new do
          class << self
            attr_accessor :is_active
            include Disableable
          end
        end
        instance.is_active = is_active
        instance
      end
      subject { disableable.active? }

      context 'when is_active equals 0' do
        let(:is_active) { 0 }

        it { is_expected.to eq(false) }
      end

      context 'when is_active equals 1' do
        let(:is_active) { 1 }

        it { is_expected.to eq(true) }
      end
    end
  end
end
