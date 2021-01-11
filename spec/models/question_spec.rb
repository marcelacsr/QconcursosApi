RSpec.describe Question, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :question_accesses }
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
    it { is_expected.to validate_inclusion_of(:answer).in_array(%w[A B C D]) }
    it { is_expected.to validate_length_of(:answer).is_at_most(1) }
  end

  describe 'scopes' do
    let!(:question) { FactoryBot.create_list :question, 5 }

    describe '#order_sum_by_discipline' do
      let(:scope) { Question.order_sum_by_discipline }

      it { expect(scope).to be_present }
      it { expect(scope.count).to be 5 }
      # esta ordenado? TODO
      it { expect(scope).to eq(Question.all.group(:discipline).order('sum_daily_access DESC').sum(:daily_access)) }
    end
  end
end
