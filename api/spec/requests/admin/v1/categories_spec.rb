# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::V1::Categories', type: :request do
  let(:user) { create(:user) }

  context 'GET /categories' do
    let(:url) { '/admin/v1/categories' }
    let!(:categories) { create_list(:category, 3) }

    it 'returns all categories' do
      get url, headers: auth_header(user)
      expect(body_json['categories']).to contain_exactly(*categories.as_json(only: %i[id name]))
    end

    it 'returns success status' do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'POST /categories' do
    let(:url) { '/admin/v1/categories' }

    context 'with valid attributes' do
      let(:attributes) { { category: attributes_for(:category) }.to_json }

      it 'creates a new category' do
        expect do
          post url, headers: auth_header(user), params: attributes
        end.to change(Category, :count).by(1)
      end

      it 'returns last created category' do
        post url, headers: auth_header(user), params: attributes
        expect_category = Category.last.as_json(only: %i[id name])

        expect(body_json['category']).to eq(expect_category)
      end

      it 'returns success status' do
        post url, headers: auth_header(user), params: attributes
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { { category: attributes_for(:category, name: nil) }.to_json }

      it "doesn't create a new category" do
        expect do
          post url, headers: auth_header(user), params: attributes
        end.to_not change(Category, :count)
      end

      it 'returns error message' do
        post url, headers: auth_header(user), params: attributes
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable entity status' do
        post url, headers: auth_header(user), params: attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'PATCH /categories/:id' do
    let(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    context 'with valid params' do
      let(:new_name) { "#{category.name}-updated" }
      let(:attributes) { { category: { name: new_name } }.to_json }

      it 'updates category' do
        patch url, headers: auth_header(user), params: attributes
        category.reload
        expect(category.name).to eq new_name
      end

      it 'returns updated category' do
        patch url, headers: auth_header(user), params: attributes
        category.reload
        expect_category = Category.last.as_json(only: %i[id name])
        expect(body_json['category']).to eq(expect_category)
      end

      it 'returns success status' do
        patch url, headers: auth_header(user), params: attributes
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:attributes) { { category: { name: nil } }.to_json }

      it 'does not update category' do
        old_name = category.name
        patch url, headers: auth_header(user), params: attributes
        category.reload
        expect(category.name).to eq old_name
      end

      it 'returns unprocessable_entity status' do
        patch url, headers: auth_header(user), params: attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        patch url, headers: auth_header(user), params: attributes
        expect(body_json['errors']['fields']).to have_key('name')
      end
    end
  end

  context 'DELETE /categories/:id' do
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    it 'removes category' do
      expect do
        delete url, headers: auth_header(user)
      end.to change(Category, :count).by(-1)
    end

    it 'returns success status' do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it 'does not return any body content' do
      delete url, headers: auth_header(user)
      expect(body_json).to eq({})
    end
  end
end
