RSpec.describe 'QuestionAccesses', type: :request do
  describe 'GET /question_accesses' do
    let(:json_body) { JSON.parse(response.body, symbolize_names: true) }

    context 'valid params' do
      let!(:question_accesses) do
        FactoryBot.create_list(:question_access, 5, question: question) do |question_access, i|
          question_access.date = Date.today + (1 * i).day
        end
      end

      let!(:question_accesses2) do
        FactoryBot.create_list(:question_access, 2, question: question2) do |question_access, i|
          question_access.date = Date.today + (1 * i).day
        end
      end

      let!(:question) { FactoryBot.create :question }
      let!(:question2) { FactoryBot.create :question }
      let(:year) { Date.today.year.to_s }
      let(:month) { "#{Date.today.year}-#{Date.today.month.to_s.rjust(2, '0')}" }
      let(:week) { (Date.today - 7.days).to_s }

      context 'params year' do
        before(:each) do
          get question_accesses_path params: { year: year }
        end

        it 'returns status 200 ok' do
          expect(response).to have_http_status(200)
          expect(response.header['Content-Type']).to include 'application/json'
        end

        it 'returns questions' do
          expect(json_body.first[:question_id]).to be_present
          expect(json_body.first[:times_accessed]).to be_present
        end
      end

      context 'params month' do
        before(:each) do
          get question_accesses_path params: { month: month }
        end

        it 'returns status 200 ok' do
          expect(response).to have_http_status(200)
          expect(response.header['Content-Type']).to include 'application/json'
        end

        it 'returns questions' do
          expect(json_body.first[:question_id]).to be_present
          expect(json_body.first[:times_accessed]).to be_present
        end
      end
      context 'params week' do
        before(:each) do
          get question_accesses_path params: { week: week }
        end

        it 'returns status 200 ok' do
          expect(response).to have_http_status(200)
          expect(response.header['Content-Type']).to include 'application/json'
        end

        it 'returns questions' do
          expect(json_body.first[:question_id]).to be_present
          expect(json_body.first[:times_accessed]).to be_present
        end
      end

      context 'all params' do
        before(:each) do
          get question_accesses_path params: { year: year, month: month, week: week }
        end

        it 'returns status 200 ok' do
          expect(response).to have_http_status(200)
          expect(response.header['Content-Type']).to include 'application/json'
        end

        it 'returns questions' do
          expect(json_body.first[:question_id]).to be_present
          expect(json_body.first[:times_accessed]).to be_present
        end
      end
    end

    context 'invalid params' do
      let(:invalid_params) { 'invalid' }

      context 'params year' do
        before(:each) do
          get question_accesses_path params: { year: invalid_params }
        end

        it 'returns status 400 bad request' do
          expect(response).to have_http_status(400)
          expect(response.header['Content-Type']).to include 'application/json'
        end

        it { expect(json_body[:error]).to eq I18n.t('question_accesses_controller.index.invalid_params') }
      end

      context 'params month' do
        before(:each) do
          get question_accesses_path params: { month: invalid_params }
        end

        it 'returns status 400 bad request' do
          expect(response).to have_http_status(400)
          expect(response.header['Content-Type']).to include 'application/json'
        end

        it { expect(json_body[:error]).to eq I18n.t('question_accesses_controller.index.invalid_params') }
      end

      context 'params week' do
        before(:each) do
          get question_accesses_path params: { week: invalid_params }
        end

        it 'returns status 400 bad request' do
          expect(response).to have_http_status(400)
          expect(response.header['Content-Type']).to include 'application/json'
        end

        it { expect(json_body[:error]).to eq I18n.t('question_accesses_controller.index.invalid_params') }
      end

      context 'all params' do
        before(:each) do
          get question_accesses_path params: { year: invalid_params, month: invalid_params, week: invalid_params }
        end

        it 'returns status 400 bad request' do
          expect(response).to have_http_status(400)
          expect(response.header['Content-Type']).to include 'application/json'
        end

        it { expect(json_body[:error]).to eq I18n.t('question_accesses_controller.index.invalid_params') }
      end
    end

    context 'no params' do
      before(:each) do
        get question_accesses_path
      end

      it 'returns status 400 bad request' do
        expect(response).to have_http_status(400)
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it { expect(json_body[:error]).to eq I18n.t('question_accesses_controller.index.missing_params') }
    end

    context 'blank params' do
      before(:each) do
        get question_accesses_path params: { year: '', month: '', week: '' }
      end

      it 'returns status 400 bad request' do
        expect(response).to have_http_status(400)
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it { expect(json_body[:error]).to eq I18n.t('question_accesses_controller.index.missing_params') }
    end
  end
end
