RSpec.describe 'Questions', type: :request do
  describe 'GET /questions' do
    context 'has questions' do
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

      before(:each) do
        get questions_path
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response.body).to include 'discipline' }
      it { expect(response.body).to include 'daily_access' }
      it { expect(response.header['Content-Type']).to include 'application/json' }
    end

    context 'doesnt have questions' do
      before(:each) do
        get questions_path
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response.body).not_to include 'discipline' }
      it { expect(response.body).not_to include 'daily_access' }
      it { expect(response.header['Content-Type']).to include 'application/json' }
    end
  end
end
