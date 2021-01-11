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
    let!(:question_accesses) do
      FactoryBot.create_list(:question_access, 5, question: question) do |question_access, i|
        question_access.date = Date.today + (2 * i).day
      end
    end

    let(:date) { Date.today }
    let(:date_month) { date.month.to_s.rjust(2, '0') }

    describe '#by_year' do
      let(:scope) { QuestionAccess.by_year(date) }

      it { expect(scope).to be_present }
      it { expect(scope.count).to eq 5 }
      it { expect(scope.to_sql).to include("BETWEEN '#{date.year}-01-01' AND '#{date.year}-12-31'") }
    end

    describe '#by_month' do
      let(:scope) { QuestionAccess.by_month(date) }

      it {
        expect(scope.to_sql).to include("BETWEEN '#{date.year}-#{date_month}-01' AND '#{date.year}-#{date_month}-31'")
      }
    end

    describe '#by_week' do
      let(:scope) { QuestionAccess.by_week(date) }

      it { expect(scope.to_sql).to include("BETWEEN '#{date.beginning_of_week}' AND '#{date.at_end_of_week}'") }
    end
  end
end
