require 'rails_helper'

RSpec.describe Seat, type: :model do
  describe 'associations' do
    it { should belong_to(:movie_room) }
    it { should have_many(:reservations) }
  end

  describe 'validations' do
    subject { build(:seat) }

    it { should validate_presence_of(:row_number) }
    it { should validate_numericality_of(:row_number).is_greater_than(0) }

    it { should validate_presence_of(:column_number) }
    it { should validate_numericality_of(:column_number).is_greater_than(0) }

    it { should validate_presence_of(:label) }
    it { should validate_uniqueness_of(:label).scoped_to(:movie_room_id) }

    it { should validate_inclusion_of(:seat_type).in_array(%w[regular wheelchair couple]) }
  end

  describe 'custom validations' do
    describe '#unique_position_in_room' do
      let(:movie_room) { create(:movie_room) }
      let!(:existing_seat) { create(:seat, movie_room: movie_room, row_number: 1, column_number: 1) }
      let(:new_seat) { build(:seat, movie_room: movie_room, row_number: 1, column_number: 1) }

      it 'não permite criar assento na mesma posição' do
        expect(new_seat).not_to be_valid
        expect(new_seat.errors[:base]).to include('Já existe um assento nesta posição')
      end

      it 'permite criar assento em posição diferente' do
        new_seat.column_number = 2
        expect(new_seat).to be_valid
      end

      it 'permite criar assento com mesma posição em salas diferentes' do
        new_seat.movie_room = create(:movie_room)
        expect(new_seat).to be_valid
      end
    end
  end
end
