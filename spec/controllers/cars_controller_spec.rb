describe CarsController do
  let(:car) {FactoryGirl.create(:car, description: 'car for wedding')}
  let(:car_from_other_wedding) {FactoryGirl.create(:car, wedding_id: car.wedding_id + 1)}

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = car.wedding.user
    sign_in @user
  end

  describe 'create car via ajax' do
    it 'should create a car' do
      expect { xhr :post, :create }.to change(@user.wedding.cars, :count).by(1)
    end
  end

  describe 'update car via ajax' do
    it 'should update car' do
      xhr :put, :update, {id: car.id, car: {driver: 'some driver', paid: 500}}
      car.reload
      car.driver.should == 'some driver'
      car.paid.should == 500
    end

    it 'should not update car from other wedding' do
      xhr :put, :update, {id: car_from_other_wedding.id, car: {driver: 'new driver'}}
      car_from_other_wedding.reload
      car_from_other_wedding.driver.should == nil
    end
  end

  describe 'delete car via ajax' do
    it 'should delete car' do
      expect {xhr :delete, :destroy, {id: car.id}}.to change(@user.wedding.cars, :count).by(-1)
    end

    it 'should not delete car from other wedding' do
      expect {xhr :delete, :destroy, {id: car_from_other_wedding.id}}.to change(@user.wedding.cars, :count).by(0)
    end
  end

end