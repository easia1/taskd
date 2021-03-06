require 'rails_helper'

describe Article, type: :model do

    let!(:article) {Article.new}

    context 'Validations' do
        it '1. Is not valid without a name' do
            article.body = 'Sample body'
            article.name = nil

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:name)
        end

        it '2. Is not valid without a body' do
            article.name = 'Sample name'
            article.body = nil

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:body)
        end

        it '3. Creates a new article if attributes are valid' do
            article_count = Article.count # assume 0 initially
            article.name = 'name'
            article.body = 'body'

            article.save!

            expect(Article.count).to eq(1)
        end

        it '4. Name should have a minimum of 3 characters' do
            article.name = 'An'
            article.body = 'Sample body'

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:name)
        end

        it '5. Body should have a maximum of 240 characters' do
            article.name = 'Example'
            article.body = 'Otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters otters'

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:body)
        end
    end
end