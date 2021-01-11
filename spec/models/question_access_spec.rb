RSpec.describe QuestionAccess, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :question }
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

    let!(:question_accesses) do
      FactoryBot.create_list(:question_access, 5, question: question) do |question_access, i|
        question_access.date = Date.today + (2 * i).day
      end
    end

    let!(:question) do
      FactoryBot.create :question
    end

    describe '#by_year' do
      let(:scope) { QuestionAccess.by_year(question_access.date) }

      it { expect(scope).to be_present }
      it { expect(scope.count).to be 1 }
      it { expect(scope.first.date).to eq(question_access.date) }
    end

    describe '#by_month' do
      let(:scope) { QuestionAccess.by_month(question_access.date) }

      it { expect(scope).to be_present }
      it { expect(scope.count).to be 1 }
      it { expect(scope.first.date).to eq(question_access.date) }
    end

    describe '#by_week' do
      let(:scope) { QuestionAccess.by_month(question_access.date) }

      it { expect(scope).to be_present }
      it { expect(scope.count).to be 1 }
      it { expect(scope.first.date).to eq(question_access.date) }
    end
  end
end
