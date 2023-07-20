require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'contact' do
    let(:contact_form) { FactoryBot.build(:contact_form) }
    let(:mail) { UserMailer.contact(contact_form) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Email from User')
      expect(mail.to).to eq([contact_form.email])
      expect(mail.from).to eq(['mail_sender@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(contact_form.text)
    end
  end
end
