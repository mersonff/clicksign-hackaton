require 'rails_helper'

RSpec.describe MatchBatchImport, type: :model do

  describe 'Validations' do
    it { is_expected.to define_enum_for(:status) }
    it { is_expected.to validate_content_type_of(:csv).allowing('text/csv') }
  end

  describe 'Attachment' do
    let(:batch_import) { create(:match_batch_import, :with_attachment) }

    it 'should have a csv attached' do
      expect(batch_import.csv.attached?).to be(true)
    end
  end
end