require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'send_mail' do
    it '指定したアドレスからメールが送信されていること' do
      UserMailer.with(name: 'さかい', to: "to@example.com").welcome.deliver_now
      expect(ActionMailer::Base.deliveries.last.from.first).to eq ('from@example.com')
    end

    it '指定した送信先のアドレスであること' do
      UserMailer.with(name: 'さかい', to: "to@example.com").welcome.deliver_now
      expect(ActionMailer::Base.deliveries.last.to.first).to eq ('to@example.com')
    end

    it '正常にメールが送信されていること' do
      UserMailer.with(name: 'さかい', to: "to@example.com").welcome.deliver_now
      expect(ActionMailer::Base.deliveries.last.subject).to eq ('登録完了')
    end

# DRYに書くと・・
    subject(:mail) do
      described_class.with(name: 'さかい', to: "to@example.com").welcome.deliver_now
      ActionMailer::Base.deliveries.last
    end

    context 'when send_mail' do
      it { expect(mail.from.first).to eq('from@example.com') }
      it { expect(mail.to.first).to eq('to@example.com') }
      it { expect(mail.subject).to eq('登録完了') }
    end
  end
end
