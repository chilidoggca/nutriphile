require 'rails_helper'

RSpec.describe DiariesController, type: :controller do
  let(:user) {FactoryBot.create(:user)}
  let(:user_1) {FactoryBot.create(:user)}

  describe '#new' do
    context 'with signed in user' do
      before do
        request.session[:user_id] = user.id
      end
      it 'renders the new template' do
        # GIVEN (defaults) ...
        # WHEN: we make a get request from user to make new diary entry
        get :new, params: { user_id: user.id }
        # THEN we expect that the new template is rendered
        expect(response).to render_template(:new)

      end

      it 'sets an instance variable with a new diary' do
        get :new, params: { user_id: user.id }
        expect(assigns(:diary)).to be_a_new(Diary)
      end
    end

    context 'without signed in user' do
      it 'redirects to sign in page' do
        get :new, params: { user_id: user.id }
        expect(response).to redirect_to(new_user_session_path)
        # test fails because authenticate_user! does not result in redirect, but status 200
      end
      it 'loads sign in page' do
        get :new, params: { user_id: user.id }
        expect(response).to render_template(:new, controller: :user_session)
      end
    end

  end


  describe '#create' do
    context 'with signed in user' do
      before do
        request.session[:user_id] = user.id
      end
      context 'with valid parameters' do
        def valid_request
          post :create, params: {
            user_id: user.id,
            diary: FactoryBot.attributes_for(:diary)
          }
        end
        it 'creates a new diary in the database' do
          count_before = Diary.count
          valid_request
          count_after = Diary.count
          expect(count_after).to eq(count_before + 1)
        end

        it 'redirects to the show page of that diary' do
          valid_request
          expect(response).to redirect_to(diary_path(Diary.last))
        end

        it 'sets a flash message' do
          valid_request
          expect(flash[:notice]).to be
        end

      end


      context 'with invalid parameters' do
        def invalid_request
          post :create, params: {
            diary: FactoryBot.attributes_for(:diary).merge({title: nil})
          }
        end

        it 'doesn\'t create a diary in the database' do
          count_before = Diary.count
          invalid_request
          count_after = Diary.count
          expect(count_before).to eq(count_after)
        end

        it 'renders the new template' do
          invalid_request
          expect(response).to render_template(:new)
        end
      end

    end

    context 'without signed in user' do
      def valid_request
        post :create, params: {
          diary: FactoryBot.attributes_for(:diary)
        }
      end
      it 'redirects to sign in page' do
        valid_request
        expect(response).to redirect_to(new_session_path)
      end
    end
  end


  describe '#show' do
    def valid_request
      # GIVEN There's a campaign in the db
      @diary = FactoryBot.create(:diary)
      # WHEN we make a request to show that campaign
      get :show, params: { id: @diary.id }
    end

    it 'renders the show template' do
      valid_request
      # Then: We it renders the show template
      expect(response).to render_template(:show)
    end

    # /campaigns/20
    it 'assigns an instance variable to campaign whose id is in the params' do
      valid_request
      # Then: We it renders the show template
      expect(assigns(:diary)).to eq(@diary)
    end
  end

  describe '#index' do
    context 'with signed in user' do
      before do
        request.session[:user_id] = user.id
      end
      it 'renders index page' do
        get :index, params: {user_id: user.id}
        expect(response).to render_template(:index)
      end
      it 'lists diaries' do
        diary_entries_count = Diary.count
        get :index
        expect(assigns(:diary).count).to eq(diary_entries_count)
      end
      it 'lists diarys by desc creation' do
        FactoryBot.create(:diary, title: '00001')
        FactoryBot.create(:diary, title: '00002')
        FactoryBot.create(:diary, title: '00003')
        get :index
        expect(assigns(:diarys).first.title).to eq('00003')
      end
    end
    context 'without signed in user' do
      it 'redirects user to sign in page' do
        get :index
        expect(response).to raise_exception
      end
    end
  end

  describe '#destroy' do
    context 'with authorized user' do
      before do
        request.session[:user_id] = user.id
      end
      it 'removes a record from the database' do
        # Given: We have a diary in the db
        diary = FactoryBot.create(:diary, user: user)
        count_before = Diary.count
        # WHEN we make a delete request with that diary's id
        delete :destroy, params: {id: diary.id}
        count_after = Diary.count
        # THEN we expect the db to have one fewer diary
        expect(count_after).to eq(count_before - 1)
      end

      it 'redirects to the index' do
        diary = FactoryBot.create(:diary, user: user)
        delete :destroy, params: {id: diary.id}
        expect(response).to redirect_to(diarys_path)
      end

      it 'alerts the user with flash' do
        diary = FactoryBot.create(:diary, user: user)
        delete :destroy, params: {id: diary.id}
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
        # GIVEN a diary
        diary = FactoryBot.create(:diary, user: user)
        # WHEN: we make a get request to its edit page
        get :edit, params: {id: diary.id}
        # THEN we expect that the new template is rendered
        expect(response).to render_template(:edit)
      end
      it 'sets an instance variable with diary id params' do
        # GIVEN a diary
        diary = FactoryBot.create(:diary, user: user)
        # WHEN we make a get request to its edit page
        get :edit, params: {id: diary.id}
        # THEN we gets to the edit page of the diary we seek
        expect(assigns(:diary).id).to eq(diary.id)
      end
    end

    context 'with unauthorized user (non-diary owner)' do
      before do
        request.session[:user_id] = user_1.id
      end
      it 'redirects get request for edit page to home page' do
        diary = FactoryBot.create(:diary, user: user)
        get :edit, params: {id: diary.id}
        expect(response).to redirect_to(home_path)
      end
      it 'sends alert notification to unauthorized user on get edit request' do
        diary = FactoryBot.create(:diary, user: user)
        get :edit, params: {id: diary.id}
        expect(flash[:alert]).to be
      end
    end

    context 'with unregistered guest user' do
      it 'redirects get request for edit page to sign in page' do
        diary = FactoryBot.create(:diary, user: user)
        get :edit, params: {id: diary.id}
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
        @diary = FactoryBot.create(:diary, user: user)
        patch :update, params: {id: @diary.id, diary: {title:'new title', description:'new description'}}
      end
      def update_with_bad_arguments
        @diary = FactoryBot.create(:diary, title: 'very original unique title', user: user)
        patch :update, params: {id: @diary.id, diary: {title:'abc', description:''}}
      end
      context 'with valid arguments' do
        it 'should allow authorized user to edit page with good arguments' do
          # GIVEN a diary authorized user created
          # WHEN: authorized user makes a patch request to update their diary
          update_with_valid_arguments
          result = Diary.last.title
          # THEN we expect that updates will be saved to database
          expect(result).to eq('New title')
        end
        it 'should redirect user to diary show page' do
          # GIVEN a diary authorized user created
          # WHEN: authorized user makes a patch request to update their diary
          update_with_valid_arguments
          # THEN we expect that updates will be saved to database
          expect(response).to redirect_to(diary_path(@diary))
        end
      end
      context 'with bad arguments' do
        it 'should not save update to db' do
          # GIVEN a diary authorized user created
          # WHEN authorized user makes a patch request with bad arguments
          update_with_bad_arguments
          result = Diary.last.title
          # THEN we expect that updates will NOT be saved to database
          # expect(assigns(:diary).title).to eq('Very original unique title')
          expect(result).to eq('Very original unique title')
        end
        it 'should send user back to edit page' do
          # GIVEN a diary authorized user created
          # WHEN authorized user makes a patch request with bad arguments
          update_with_bad_arguments
          # THEN we expect that edit page will be rendered
          expect(response).to render_template(:edit)
        end
      end
    end
    #
    # context 'with unauthorized user (non-diary owner)' do
    #   before do
    #     request.session[:user_id] = user_1.id
    #   end
    #   it 'redirects get request for edit page to home page' do
    #     diary = FactoryBot.create(:diary, user: user)
    #     get :edit, params: {id: diary.id}
    #     expect(response).to redirect_to(home_path)
    #   end
    #   it 'sends alert notification to unauthorized user on get edit request' do
    #     diary = FactoryBot.create(:diary, user: user)
    #     get :edit, params: {id: diary.id}
    #     expect(flash[:alert]).to be
    #   end
    # end

    context 'with unregistered guest user' do
      it 'redirects patch request for edit page to sign in page' do
        diary = FactoryBot.create(:diary, user: user)
        patch :update, params: {id: diary.id, title:'new title', description:'new description'}
        expect(response).to redirect_to(new_session_path)
      end
      it 'should not allow title to be changed by guest user' do
        diary = FactoryBot.create(:diary, title: 'original title', user: user)
        patch :update, params: {id: diary.id, title:'new title', description:'new description'}
        expect(diary.title).to eq('Original title')
      end
    end
  end
end
