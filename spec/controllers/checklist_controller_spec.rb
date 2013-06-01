describe ChecklistController do
  let(:check_item) { FactoryGirl.create(:check_item) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = check_item.wedding.user
    sign_in @user
  end

  describe 'creating a check item' do
    it 'should create an expenditure only for current user' do
      expect { xhr :post, :create }.to change(@user.wedding.check_items, :count).by(1)
    end
  end

  describe 'delete check item' do
    it 'should delete check item only for current user' do
      expect { xhr :delete, :destroy, id: check_item.id }.to change(@user.wedding.check_items, :count).by(-1)
    end
  end
end