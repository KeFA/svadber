describe ExpendituresController do
  let(:wedding) { FactoryGirl.create(:wedding) }
  let!(:expenditure) { wedding.expenditures.create }
  let(:expenditure_from_other_wedding) { FactoryGirl.create(:expenditure, wedding_id: wedding.id + 1) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = wedding.user
    sign_in @user
  end

  describe 'creating expenditure via ajax' do
    it 'should create an expenditure' do
      expect { xhr :post, :create }.to change(Expenditure, :count).by(1)
    end

    it 'should create an expenditure only for current user' do
      expect { xhr :post, :create }.to change(@user.wedding.expenditures, :count).by(1)
    end
  end


  describe 'updating expenditure via ajax' do
    it 'should update an expenditure' do
      new_desc = 'new description'
      xhr :put, :update, {id: expenditure.id, expenditure: {description: new_desc}}
      expenditure.reload
      expenditure.description.should == new_desc
    end
  end

  describe 'delete an expenditure via ajax' do
    it 'should delete an expenditure' do
      expect { xhr :delete, :destroy, id: expenditure.id }.to change(Expenditure, :count).by(-1)
    end

    it 'should delete an expenditure only for current wedding' do
      expenditure_from_other_wedding
      expect { xhr :delete, :destroy, id: expenditure_from_other_wedding.id }.to change(Expenditure, :count).by(0)
    end
  end
end