require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'sets the schools instance variable' do
      get :index
      expect(assigns(:schools)).to eq([])
    end
  end

  describe "GET #show" do
    before(:each) do
      @school = School.create(name: 'Fake School')
    end

    it "returns http success" do
      get :show, id: @school.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, id: @school.id
      expect(response).to render_template(:show)
    end

    it "sets the school instance variable" do
      get :show, id: @school.id
      expect(assigns(:school).name).to eq(@school.name)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "sets the new instance variable" do
      get :new
      expect(assigns(:school)).to_not eq(nil)
      expect(assigns(:school).id).to eq(nil)
    end
  end

  describe "POST #create" do
      before(:all) do
        @school_params = { school: { name: 'Fake School' }}
      end
    describe 'success' do

      it "sets the school instance variable" do
        post :create, @school_params
        expect(assigns(:school)).to_not eq(nil)
        expect(assigns(:school).name).to eq(@school_params[:school][:name])
      end

      it "creates a new school" do
        expect(School.count).to eq(0)
        post :create, @school_params
        expect(School.count).to eq(1)
        expect(School.first.name).to eq(@school_params[:school][:name])
      end

      it "sets flash message on success" do
        post :create, @school_params
        expect(flash[:notice]).to eq('School added successfully.')
      end
    end

    describe 'failure' do
      it 'renders new on failure' do
        school2 = School.create(name: 'Fake School')
        post :create, @school_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    before(:each) do
      @school = School.create(name: 'Fake School')
    end

    it "returns http success" do
      get :edit, id: @school.id
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      get :edit, id: @school.id
      expect(response).to render_template(:edit)
    end

    it "sets school instance variable" do
      get :edit, id: @school.id
      expect(assigns(:school).id).to eq(@school.id)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @school = School.create(name: 'Test School')
    end

    describe 'successes' do
      it 'sets the school instance variable' do
        put :update, { id: @school.id, school: {name: 'New School' }}
        expect(assigns(:school).id).to eq(@school.id)
      end

      it 'updates the school' do
        put :update, { id: @school.id, school: {name: 'New School' }}
        expect(@school.reload.name).to eq('New School')
      end

      it 'sets flash message on success' do
        put :update, { id: @school.id, school: {name: 'New School' }}
        expect(flash[:notice]).to eq('School updated successfully.')
      end

      it 'redirects to show on success' do
        put :update, { id: @school.id, school: {name: 'New School' }}
        expect(response).to redirect_to(school_path(@school.id))
      end
    end

    describe 'failures' do
      # it 'sets flash message on error' do
      #   school2 = School.create(name: 'Fake School')
      #   put :update, { id: @school.id, school: { name: 'Fake School' }}
      #   binding.pry
      #   expect(flash[:alert]).to eq('School not updated!')
      # end

      it 'renders edit on fail' do
        school2 = School.create(name: 'Fake School')
        put :update, { id: @school.id, school: { name: 'Fake School' }}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @school = School.create(name: 'Test School')
    end

    it 'sets the school instance variable' do
        delete :destroy, id: @school.id
        expect(assigns(:school)).to eq(@school)
    end

    it 'destroys the school' do
      expect(School.count).to eq(1)
      delete :destroy, id: @school.id
      expect(School.count).to eq(0)
    end

    it 'sets the flash message' do
      delete :destroy, id: @school.id
      expect(flash[:notice]).to eq('School deleted.')
    end

    it 'redirects to index path after destroy' do
      delete :destroy, id: @school.id
      expect(response).to redirect_to(schools_path)
    end
  end

end
