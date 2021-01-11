RSpec.describe QuestionAccess, type: :model do
  describe 'associations' do
    # it { is_expected.to have_many(:question_accesses) }
  end

  describe 'validations' do
    let(:question) { FactoryBot.create :question }
    let(:question_access) { FactoryBot.create :question_access, question: question }
    subject { question_access }

    it { expect(question_access).to be_valid }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:times_accessed) }
  end

  describe 'scopes' do
    let(:question) { FactoryBot.create :question }
    let(:question_access) { FactoryBot.create :question_access, question: question }
    describe '#by_year' do

      let(:scope) {QuestionAccess.by_year(question_access.date)}

      it { expect(scope).to be_present }
      it { expect(scope.count).to be 1 }
      it { expect(scope.first.id).to eq(question_access.id) }
    end
  end
end
