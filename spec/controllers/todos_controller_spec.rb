describe TodosController do
  let(:todo) { FactoryGirl.create(:todo) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = todo.wedding.user
    sign_in @user
  end

  describe 'creating a todo item' do
    it 'should create a todo only for current user' do
      expect { xhr :post, :create, todo: {description: 'new todo', done: false} }.to change(@user.wedding.todos, :count).by(1)
    end
  end

  describe 'delete a todo item' do
    it 'should delete a todo only for current user' do
      other_todo = FactoryGirl.create(:todo)
      expect { xhr :delete, :destroy, id: other_todo.id }.to change(@user.wedding.todos, :count).by(0)

      expect { xhr :delete, :destroy, id: todo.id }.to change(@user.wedding.todos, :count).by(-1)
    end
  end
end