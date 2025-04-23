require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:reservations).dependent(:destroy) }
    it { should have_many(:showtimes).through(:reservations) }
  end

  describe "validations" do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password).on(:create) }

    context "email format" do
      it "accepts valid email addresses" do
        valid_emails = [ "user@example.com", "USER@foo.COM", "A_US-ER@foo.bar.org" ]
        valid_emails.each do |email|
          user = build(:user, email: email)
          expect(user).to be_valid
        end
      end

      it "rejects invalid email addresses" do
        invalid_emails = [ "user@example,com", "user_at_foo.org", "user.name@example." ]
        invalid_emails.each do |email|
          user = build(:user, email: email)
          expect(user).not_to be_valid
        end
      end
    end

    context "password complexity" do
      it "accepts valid passwords" do
        valid_password = "Password123!@#"
        user = build(:user, password: valid_password)
        expect(user).to be_valid
      end

      it "rejects passwords without uppercase letters" do
        user = build(:user, password: "password123!@#")
        expect(user).not_to be_valid
      end

      it "rejects passwords without lowercase letters" do
        user = build(:user, password: "PASSWORD123!@#")
        expect(user).not_to be_valid
      end

      it "rejects passwords without numbers" do
        user = build(:user, password: "Password!@#")
        expect(user).not_to be_valid
      end

      it "rejects passwords without special characters" do
        user = build(:user, password: "Password123")
        expect(user).not_to be_valid
      end

      it "rejects passwords shorter than 12 characters" do
        user = build(:user, password: "Pass123!@#")
        expect(user).not_to be_valid
      end
    end
  end

  describe "#watched_movies" do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    let(:showtime) { create(:showtime, movie: movie, start_time: 1.hour.ago) }

    before do
      create(:reservation, user: user, showtime: showtime)
    end

    it "returns movies from past showtimes" do
      expect(user.watched_movies).to include(movie)
    end

    it "does not return movies from future showtimes" do
      future_movie = create(:movie)
      future_showtime = create(:showtime, movie: future_movie, start_time: 1.hour.from_now)
      create(:reservation, user: user, showtime: future_showtime)

      expect(user.watched_movies).not_to include(future_movie)
    end

    it "returns distinct movies" do
      another_showtime = create(:showtime, movie: movie, start_time: 2.hours.ago)
      create(:reservation, user: user, showtime: another_showtime)

      expect(user.watched_movies.count).to eq(1)
    end
  end
end
