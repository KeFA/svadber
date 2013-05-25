describe ChecklistController do
  let(:wedding) { FactoryGirl.create(:wedding) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = wedding.user
    sign_in @user
  end

  describe 'creating a check item' do
    it 'should create a check item via ajax' do
      expect { xhr :post, :create }.to change(CheckItem, :count).by(1)
    end

    #it 'should create an expenditure only for current user' do
    #  expect { xhr :post, :create }.to change(@user.wedding.expenditures, :count).by(1)
    #end
  end
end