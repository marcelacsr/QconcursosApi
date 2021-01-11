RSpec.describe Question, type: :model do

  describe 'associations' do
    # it { is_expected.to have_many(:question_accesses) }
  end

  describe 'validations' do
    let(:question) { FactoryBot.create :question }
    subject { question }

    it { expect(question).to be_valid }
    it { is_expected.to validate_presence_of(:statement) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_presence_of(:answer) }
    it { is_expected.to validate_presence_of(:daily_access) }
    it { is_expected.to validate_presence_of(:discipline) }
    it { is_expected.to validate_presence_of(:created_at) }
  end
end
