describe GuestsController do
  let(:guest) { FactoryGirl.create(:guest, last_name: 'Sinkevich') }
  let!(:guest_from_other_wedding) { FactoryGirl.create(:guest, last_name: 'lorem', wedding_id: guest.wedding.id + 1) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = guest.wedding.user
    sign_in @user
  end

  describe 'creating a guest via ajax' do
    it 'should create a guest' do
      expect { xhr :post, :create }.to change(Guest, :count).by(1)
    end

    it 'should create guest for current user' do
      expect { xhr :post, :create }.to change(@user.wedding.guests, :count).by(1)
    end
  end

  describe 'updating a guest via ajax' do
    it 'should update a guest' do
      xhr :put, :update, {id: guest.id, guest: {first_name: 'Maryia', last_name: 'Rudzko', city: 'Mozyr'}}
      guest.reload
      guest.first_name.should == 'Maryia'
      guest.last_name.should == 'Rudzko'
      guest.city.should == 'Mozyr'
    end

    it 'should allow to create a guest only for current wedding' do
      xhr :put, :update, {id: guest_from_other_wedding.id, guest: {last_name: 'Rudzko'}}
      guest_from_other_wedding.reload
      guest_from_other_wedding.last_name.should == 'lorem'
    end
  end

  describe 'delete a guest via ajax' do
    it 'should delete a guest' do
      expect { xhr :delete, :destroy, id: guest.id }.to change(Guest, :count).by(-1)
    end

    it 'should allow to delete a guest only for current wedding' do
      expect { xhr :delete, :destroy, id: guest_from_other_wedding.id }.to change(Guest, :count).by(0)
    end
  end
end