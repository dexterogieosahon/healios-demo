require 'rails_helper'

describe ShortenedUrl, type: :model do  
  it { should respond_to(:url) }
  it { should respond_to(:url_key) }
  it { should respond_to(:click_count) }
  it { should respond_to(:user) }

  describe '#generate!' do
    context 'shortened url record for requested url does not exist' do
      let(:expected) { "http://google.com/" }

      shared_examples_for "shortened URL" do
        let(:shortened_url) { described_class.generate!(url, user) }

        it 'creates a shortened URL' do
          expect{shortened_url}.to change{described_class.count}.by(1)
          expect(shortened_url.url).to eq expected
          expect(shortened_url.url_key.length).to eq 5
          expect(shortened_url.user).to eq(user)
        end
      end

      context "shortened url with user" do
        it_should_behave_like "shortened URL" do
          let(:user) { create(:user) }
          let(:url) { expected }
        end
      end
    end
  end

  describe '#used!' do
    let(:user) { create(:user) }
    let(:url) { 'https://yahoo.com'}
    let(:short_url) { described_class.generate!(url, user) }

    it 'increments the click_count' do
      initial_count = short_url.click_count
      short_url.used!
      expect(short_url.reload.click_count).to eq (initial_count + 1)
    end
  end
end
