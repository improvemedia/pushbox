require "rails_helper"

RSpec.describe LetterDeliveryService do
  let(:mailing) { create :mailing }
  let!(:users) { create_pair :user }
  subject { described_class }

  context "when some users of segment already processed" do
    let(:processed_user) { users.first }
    let(:unprocessed_user) { users.last }
    let!(:sent_email) do
      create :letter, :sent, user: processed_user, mailing: mailing
    end

    it "sends only one email" do
      expect { subject.call(mailing_id: mailing.id, batch_index: 1, batch_size: 100) }
        .to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it "sends email only to unprocessed_user" do
      subject.call(mailing_id: mailing.id, batch_index: 1, batch_size: 100)
      expect(ActionMailer::Base.deliveries.last.to)
        .to contain_exactly unprocessed_user.email
    end
  end
end
