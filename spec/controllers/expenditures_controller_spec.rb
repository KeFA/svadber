describe ExpendituresController do
  let(:wedding) { FactoryGirl.create(:wedding) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = wedding.user
    sign_in @user
  end

  describe 'creating expenditure via ajax' do
    it 'should create an expenditure' do
      expect { xhr :post, :create }.to change(Expenditure, :count).by(1)
    end

    it 'should create an expenditure for current user' do
      expect { xhr :post, :create }.to change(@user.wedding.expenditures, :count).by(1)
    end
  end


  describe 'updating expenditure via ajax' do
    let(:expenditure) { FactoryGirl.create(:expenditure) }

    it 'should update en expenditure' do
      xhr :put, :update, {id: expenditure.id, expenditure: {description: 'new description'}}
      expenditure.reload
      expenditure.description.should == 'new description'
    end
  end
end