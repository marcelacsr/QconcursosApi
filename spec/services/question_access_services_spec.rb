RSpec.describe QuestionAccessServices do
  describe 'Methods' do
    let!(:question_accesses) do
      FactoryBot.create_list(:question_access, 5, question: question) do |question_access, i|
        question_access.date = Date.today + (2 * i).day
      end
    end

    let!(:question_accesses2) do
      FactoryBot.create_list(:question_access, 2, question: question2) do |question_access, i|
        question_access.date = Date.today + (2 * i).day
      end
    end

    let!(:question) { FactoryBot.create :question }
    let!(:question2) { FactoryBot.create :question }

    describe '#search' do
      let(:year) { Date.today.year.to_s }
      let(:month) { "#{Date.today.year}-#{Date.today.month.to_s.rjust(2, '0')}" }
      let(:week) { Date.today.to_s }

      context 'when all params' do
        let(:service) { QuestionAccessServices.new(year, month, week) }
        subject { service.search }

        it { expect(subject).to include(question_id: question.id, times_accessed: 500) }
        it { expect(subject).to include(question_id: question2.id, times_accessed: 200) }

        it 'by_year' do
          expect(QuestionAccess).to receive(:by_year).with(Date.new(year.to_i, 1, 1)).and_call_original

          subject
        end

        it 'by_month' do
          expect(QuestionAccess).not_to receive(:by_month)

          subject
        end

        it 'by_week' do
          expect(QuestionAccess).not_to receive(:by_week)

          subject
        end

        context 'when there is no records for the year' do
          it 'by_year' do
            expect(QuestionAccess).to receive(:by_year).with(Date.new(year.to_i, 1, 1)).and_call_original

            subject
          end
        end
      end

      context 'when only year is passed' do
        let(:service) { QuestionAccessServices.new(year, nil, nil) }
        subject { service.search }

        it 'returns all questions by_year' do
          expect(subject).to include(question_id: question.id, times_accessed: 500)
          expect(subject).to include(question_id: question2.id, times_accessed: 200)
        end

        it 'by_year' do
          expect(QuestionAccess).to receive(:by_year).with(Date.new(year.to_i, 1, 1)).and_call_original

          subject
        end

        it 'by_month' do
          expect(QuestionAccess).not_to receive(:by_month)

          subject
        end

        it 'by_week' do
          expect(QuestionAccess).not_to receive(:by_week)

          subject
        end
      end

      context 'when only month is passed' do
        let(:service) { QuestionAccessServices.new(nil, month, nil) }
        subject { service.search }

        it 'returns all questions by_year' do
        end

        it 'by_year' do
          expect(QuestionAccess).not_to receive(:by_year)

          subject
        end

        it 'by_month' do
          expect(QuestionAccess).to receive(:by_month).with(Date.new(year.to_i, 1, 1)).and_call_original

          subject
        end

        it 'by_week' do
          expect(QuestionAccess).not_to receive(:by_week)

          subject
        end
      end

      context 'when only week is passed' do
        let(:service) { QuestionAccessServices.new(nil, nil, week) }
        subject { service.search }

        it 'returns all questions by_year' do
        end

        it 'by_year' do
          expect(QuestionAccess).not_to receive(:by_year)

          subject
        end

        it 'by_month' do
          expect(QuestionAccess).not_to receive(:by_month)

          subject
        end

        it 'by_week' do
          expect(QuestionAccess).to receive(:by_week).with(Date.today).and_call_original

          subject
        end
      end

      context 'when only week is passed and doesnt exist' do
        let(:week) { Date.today - 8 }
        let(:service) { QuestionAccessServices.new(nil, nil, week.to_s) }
        subject { service.search }

        it 'by_week' do
          expect(QuestionAccess).to receive(:by_week).with(week).and_return [] # .and_call_original

          subject
        end
      end
    end
  end
end
