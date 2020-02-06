require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let!(:category) { create(:category) }
  let(:expense) { create(:purchase, category_id: category.id) }
  let(:valid_attr_expense) { attributes_for(:purchase, category_id: category.id) }
  let(:invalid_attr_expense) { attributes_for(:invalid_expense) }
  
  describe 'GET #index' do
    it 'assigns :expenses to @tab' do
      get :index
      expect(assigns(:tab)).to eq(:expenses)
    end

    context 'with params' do
      it 'populates an array of expenses fitered by category' do
        purchase = create(:purchase, category_id: category.id)
        category_two = create(:category)
        payment = create(:payment, category_id: category_two.id)

        get :index, category: category_two.id
        expect(assigns(:expenses)).to eq([payment])
      end

      it 'populates an array of expenses fitered by transaction type' do
        purchase = create(:purchase, category_id: category.id)
        payment = create(:payment, category_id: category.id)

        get :index, transaction_type: Expense::transaction_types[:payment]
        expect(assigns(:expenses)).to eq([payment])
      end

      it 'populates an array of expenses fitered by month' do
        purchase = create(:purchase, category_id: category.id, date: Date.today)
        payment = create(:payment, category_id: category.id, date: (Date.today - 90))

        get :index, month_ago: 3
        expect(assigns(:expenses)).to eq([payment])
      end
    end

    context 'without params' do
      it 'populates an array of all expenses sorted by created date' do
        purchase = create(:purchase, category_id: category.id)
        payment = create(:payment, category_id: category.id)
        get :index
        expect(assigns(:expenses)).to eq([payment, purchase])
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new Expense to @expense' do
      xhr :get, :new, format: :js
      expect(assigns(:expense)).to be_a_new(Expense)
    end

    it 'renders the :new template' do
      xhr :get, :new, format: :js
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested expense to @expense' do
      xhr :get, :edit, id: expense.id, format: :js
      expect(assigns(:expense)).to eq(expense)
    end

    it 'renders the :edit template' do
      xhr :get, :edit, id: expense.id, format: :js
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new expense in the database' do
        expect{
          xhr :post, :create, format: :js, expense: valid_attr_expense
        }.to change(Expense, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new expense in the database' do
        expect{
          xhr :post, :create, format: :js,
            expense: invalid_attr_expense
        }.not_to change(Expense, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'locates the requested @expense' do
        xhr :patch, :update, id: expense.id, expense: valid_attr_expense, format: :js
        expect(assigns(:expense)).to eq(expense)
      end

      it 'changes expenses attributes' do
        xhr :patch, :update, id: expense.id, expense: attributes_for(:expense, concept: 'Expense edited'), format: :js
        expense.reload

        expect(expense.concept).to eq 'Expense edited'
      end
    end

    context 'with invalid attributes' do
      it 'does not change the expenses attributes' do
        xhr :patch, :update, id: expense.id, expense: invalid_attr_expense, format: :js
        expense.reload

        expect(expense.concept).not_to eq nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it "deletes the expense" do
      expense
      expect{
        xhr :delete, :destroy, id: expense.id, format: :js
      }.to change(Expense,:count).by(-1)
    end
  end
end
