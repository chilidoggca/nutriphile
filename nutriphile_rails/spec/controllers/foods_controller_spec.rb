require 'rails_helper'

RSpec.describe FoodsController, type: :controller do

  describe '#show' do
    context 'with valid request' do
      def valid_request
        # GIVEN There's a food in the db
        @food = Food.find(10)
        # WHEN we make a request to show that food
        get :show, params: { id: @food.id }
      end

      it 'renders the show template' do
        valid_request
        # Then: We it renders the show template
        expect(response).to render_template(:show)
      end

      # /foods/20
      it 'assigns an instance variable to food whose id is in the params' do
        valid_request
        # Then: We it renders the show template
        expect(assigns(:food)).to eq(@food)
      end
    end

    context 'with invalid request' do
      def invalid_request
        # GIVEN There is no food with matching id
        @food = Food.find(90000)
        # WHEN we make a request to show that food
        get :show, params: { id: @food.id }
      end

      it 'renders the show template' do
        invalid_request
        # Then: We it renders the show template
        expect(response).to render_template(:show)
      end

    end

  end

  describe '#index' do
    it 'get index renders index' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'lists foods' do
      # count_before = Food.count
      FactoryBot.create(:food, title: '00001')
      FactoryBot.create(:food, title: '00002')
      FactoryBot.create(:food, title: '00003')
      get :index
      expect(assigns(:foods).count).to eq(3)
    end
    it 'lists foods by desc creation' do
      FactoryBot.create(:food, title: '00001')
      FactoryBot.create(:food, title: '00002')
      FactoryBot.create(:food, title: '00003')
      get :index
      expect(assigns(:foods).first.title).to eq('00003')
    end
  end

  describe '#destroy' do
    context 'with authorized user' do
      before do
        request.session[:user_id] = user.id
      end
      it 'removes a record from the database' do
        # Given: We have a food in the db
        food = FactoryBot.create(:food, user: user)
        count_before = Food.count
        # WHEN we make a delete request with that food's id
        delete :destroy, params: {id: food.id}
        count_after = Food.count
        # THEN we expect the db to have one fewer food
        expect(count_after).to eq(count_before - 1)
      end

      it 'redirects to the index' do
        food = FactoryBot.create(:food, user: user)
        delete :destroy, params: {id: food.id}
        expect(response).to redirect_to(foods_path)
      end

      it 'alerts the user with flash' do
        food = FactoryBot.create(:food, user: user)
        delete :destroy, params: {id: food.id}
        expect(flash[:alert]).to be
      end
    end
  end

  describe '#edit' do
    context 'with authorized signed in user' do
      before do
        request.session[:user_id] = user.id
      end
      it 'renders the edit template' do
        # GIVEN a food
        food = FactoryBot.create(:food, user: user)
        # WHEN: we make a get request to its edit page
        get :edit, params: {id: food.id}
        # THEN we expect that the new template is rendered
        expect(response).to render_template(:edit)
      end
      it 'sets an instance variable with food id params' do
        # GIVEN a food
        food = FactoryBot.create(:food, user: user)
        # WHEN we make a get request to its edit page
        get :edit, params: {id: food.id}
        # THEN we gets to the edit page of the food we seek
        expect(assigns(:food).id).to eq(food.id)
      end
    end

    context 'with unauthorized user (non-food owner)' do
      before do
        request.session[:user_id] = user_1.id
      end
      it 'redirects get request for edit page to home page' do
        food = FactoryBot.create(:food, user: user)
        get :edit, params: {id: food.id}
        expect(response).to redirect_to(home_path)
      end
      it 'sends alert notification to unauthorized user on get edit request' do
        food = FactoryBot.create(:food, user: user)
        get :edit, params: {id: food.id}
        expect(flash[:alert]).to be
      end
    end

    context 'with unregistered guest user' do
      it 'redirects get request for edit page to sign in page' do
        food = FactoryBot.create(:food, user: user)
        get :edit, params: {id: food.id}
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

  describe 'update' do
    context 'with authorized signed in user' do
      before do
        request.session[:user_id] = user.id
      end
      def update_with_valid_arguments
        @food = FactoryBot.create(:food, user: user)
        patch :update, params: {id: @food.id, food: {title:'new title', description:'new description'}}
      end
      def update_with_bad_arguments
        @food = FactoryBot.create(:food, title: 'very original unique title', user: user)
        patch :update, params: {id: @food.id, food: {title:'abc', description:''}}
      end
      context 'with valid arguments' do
        it 'should allow authorized user to edit page with good arguments' do
          # GIVEN a food authorized user created
          # WHEN: authorized user makes a patch request to update their food
          update_with_valid_arguments
          result = Food.last.title
          # THEN we expect that updates will be saved to database
          expect(result).to eq('New title')
        end
        it 'should redirect user to food show page' do
          # GIVEN a food authorized user created
          # WHEN: authorized user makes a patch request to update their food
          update_with_valid_arguments
          # THEN we expect that updates will be saved to database
          expect(response).to redirect_to(food_path(@food))
        end
      end
      context 'with bad arguments' do
        it 'should not save update to db' do
          # GIVEN a food authorized user created
          # WHEN authorized user makes a patch request with bad arguments
          update_with_bad_arguments
          result = Food.last.title
          # THEN we expect that updates will NOT be saved to database
          # expect(assigns(:food).title).to eq('Very original unique title')
          expect(result).to eq('Very original unique title')
        end
        it 'should send user back to edit page' do
          # GIVEN a food authorized user created
          # WHEN authorized user makes a patch request with bad arguments
          update_with_bad_arguments
          # THEN we expect that edit page will be rendered
          expect(response).to render_template(:edit)
        end
      end
    end
    #
    # context 'with unauthorized user (non-food owner)' do
    #   before do
    #     request.session[:user_id] = user_1.id
    #   end
    #   it 'redirects get request for edit page to home page' do
    #     food = FactoryBot.create(:food, user: user)
    #     get :edit, params: {id: food.id}
    #     expect(response).to redirect_to(home_path)
    #   end
    #   it 'sends alert notification to unauthorized user on get edit request' do
    #     food = FactoryBot.create(:food, user: user)
    #     get :edit, params: {id: food.id}
    #     expect(flash[:alert]).to be
    #   end
    # end

    context 'with unregistered guest user' do
      it 'redirects patch request for edit page to sign in page' do
        food = FactoryBot.create(:food, user: user)
        patch :update, params: {id: food.id, title:'new title', description:'new description'}
        expect(response).to redirect_to(new_session_path)
      end
      it 'should not allow title to be changed by guest user' do
        food = FactoryBot.create(:food, title: 'original title', user: user)
        patch :update, params: {id: food.id, title:'new title', description:'new description'}
        expect(food.title).to eq('Original title')
      end
    end
  end
end
