require 'rails_helper'

RSpec.describe UsersController do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }

  before do
    sign_in user_1
  end

  describe 'GET #index' do
    before { get :index }

    it 'assigns all users into @users' do
      expect(assigns(:users)).to match_array([user_1, user_2])
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    context 'with valid attributes' do
      before { get :show, params: { id: user_1.id } }

      it 'assigns the user to @user' do
        expect(assigns(:user)).to eq user_1
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'with invalid attributes' do
      before { get :show, params: { id: 0 } }

      it 'shows error message' do
        expect(flash[:danger]).to eq "Couldn't find User with 'id'=0"
      end
    end
  end
end
