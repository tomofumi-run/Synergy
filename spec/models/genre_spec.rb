# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:genre) { create(:genre) }

    context '保存できない場合' do
      it '空欄では保存できない' do
        genre.name = ''
        expect(genre).not_to be_valid
      end
    end

    context '保存できる場合' do
      it '中身が入っている' do
        genre.name = Faker::Lorem.characters(number: 5)
        expect(genre).to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
