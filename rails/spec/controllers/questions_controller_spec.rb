require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  valid_question_params = { question: "What is the color of the sky?", answer: "Blue" }
  invalid_question_params = { question: nil, answer: nil }
  existing_question = FactoryGirl.create :question

  describe 'GET #index' do
    it 'renders index' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'renders new' do
      get :new, id: 1
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it 'creates a question' do
        expect{ post :create, question: valid_question_params }.to change(Question, :count).by 1
      end

      it 'redirects to home page' do
        post :create, question: valid_question_params
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      it 'fails to create a question' do
        expect{ post :create, question: invalid_question_params }.to_not change(Question, :count)
      end

      it 'rerender :new' do
        post :create, question: invalid_question_params
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context "with valid attributes" do
      before :each do
        put :update, id: existing_question, question: valid_question_params
      end

      it 'updates existing_question' do
        existing_question.reload
        expect(existing_question.question).to eq valid_question_params[:question]
        expect(existing_question.answer).to eq valid_question_params[:answer]
      end

      it 'redirects to home page' do
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      before :each do
        put :update, id: existing_question, question: invalid_question_params
      end

      it 'fails to update a question' do
        previous_data = existing_question
        existing_question.reload
        expect(existing_question.question).to eq previous_data.question
        expect(existing_question.answer).to eq previous_data.answer
      end

      it 'redirects to :edit' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST #answer' do
    context "with correct answer" do
      it 'redirects to home page' do
        post :answer, id: existing_question, answer: { answer: existing_question.answer }
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to be_present
      end
    end

    context "with incorrect answer" do
      it 'rerenders show' do
        post :answer, id: existing_question, answer: { answer: existing_question.answer + " wrong" }
        expect(response).to render_template :show
      end
    end
  end

end
