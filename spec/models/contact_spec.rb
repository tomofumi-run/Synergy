# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:contact) { create(:contact) }

    context 'nameカラム' do
      it '空欄はNG' do
        contact.name = ''
        expect(contact).not_to be_valid
      end
      it '16字以上はNG' do
        contact.name = Faker::Lorem.characters(number: 16)
        expect(contact).not_to be_valid
      end
      it '15文字以内はOK' do
        contact.name = Faker::Lorem.characters(number: 15)
        expect(contact).to be_valid
      end
    end

    context 'emailカラム' do
      it '空欄はNG' do
        contact.email = ''
        expect(contact).not_to be_valid
      end
      it '正規表記でしか登録できないこと' do
        contact.email = 'user@example,com'
        expect(contact).not_to be_valid

        contact.email = 'user_at_foo.org'
        expect(contact).not_to be_valid

        contact.email = 'user.name@example.'
        expect(contact).not_to be_valid

        contact.email = 'foo@bar_baz.com'
        expect(contact).not_to be_valid

        contact.email = 'foo@bar+baz.com'
        expect(contact).not_to be_valid
      end
    end

    context 'subjectカラム' do
      it '空欄はNG' do
        contact.subject = ''
        expect(contact).not_to be_valid
      end
      it '21字以上はNG' do
        contact.subject = Faker::Lorem.characters(number: 21)
        expect(contact).not_to be_valid
      end
      it '20文字以内はOK' do
        contact.subject = Faker::Lorem.characters(number: 20)
        expect(contact).to be_valid
      end
    end

    context 'messageカラム' do
      it '空欄はNG' do
        contact.message = ''
        expect(contact).not_to be_valid
      end
    end
  end
end
