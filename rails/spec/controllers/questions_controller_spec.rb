require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  valid_question_params = { question: "What is the color of the sky?", answer: "Blue" }
  invalid_question_params = { question: nil, answer: nil }
  existing_question = FactoryGirl.create :question

  describe 'GET #index' do
    it 'renders index' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #new' do
    it 'renders new' do
      get :new, id: 1
      response.should render_template :new
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it 'creates a question' do
        expect{ post :create, question: valid_question_params }.to change(Question, :count).by 1
      end

      it 'redirects to home page' do
        post :create, question: valid_question_params
        response.should redirect_to root_path
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      it 'fails to create a question' do
        expect{ post :create, question: invalid_question_params }.to_not change(Question, :count)
      end

      it 'rerender :new' do
        post :create, question: invalid_question_params
        response.should render_template :new
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
        existing_question.question.should eq valid_question_params[:question]
        existing_question.answer.should eq valid_question_params[:answer]
      end

      it 'redirects to home page' do
        response.should redirect_to root_path
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
        existing_question.question.should eq previous_data.question
        existing_question.answer.should eq previous_data.answer
      end

      it 'redirects to :edit' do
        response.should render_template :edit
      end
    end
  end

  describe 'POST #answer' do
    context "with correct answer" do
      it 'redirects to home page' do
        question = Question.first
        post :answer, id: 1, answer: { answer: question.answer }
        response.should redirect_to root_path
        expect(flash[:notice]).to be_present
      end
    end

    context "with incorrect answer" do
      before(:each) do
        request.env["HTTP_REFERER"] = "where_i_came_from"
      end

      it 'refreshes page' do
        question = Question.first
        post :answer, id: 1, answer: { answer: question.answer + " wrong" }
        response.should redirect_to "where_i_came_from"
        expect(flash[:notice]).to be_present
      end
    end
  end

end
