require 'rails_helper'

RSpec.describe 'Api::V1::Todos', type: :request do
  describe 'GET /api/v1/todos' do
    before do
      create_list(:todo, 3)
    end
    it 'TODOリストを取得する' do
      get '/api/v1/todos'
      
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      expect(json['data'].length).to eq(3)
    end
  end

  describe 'GET /api/v1/todos/:id' do
    let!(:todo) { create(:todo, content: '猫買う') }
    it '特定のTODOを取得する' do
      get "/api/v1/todos/#{todo.id}"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['data']['id'].to_i).to eq(todo.id)
    end
  end

  describe 'POST /api/v1/todos' do
    it 'TODOを作成する' do
      expect do
        post '/api/v1/todos', params: { todo: { content: '新しいTODO' } }
        expect(response).to have_http_status(:created)
      end.to change(Todo, :count).by(1)
    end
  end

  describe 'PUT /api/v1/todos/:id' do
    let!(:todo) { create(:todo, content: '古いTODO') }
    it 'TODOを更新する' do
      expect do
        put "/api/v1/todos/#{todo.id}", params: { todo: { content: '更新されたTODO' } }
        expect(response).to have_http_status(:success)
      end.not_to change(Todo, :count)
    end
  end

  describe 'DELETE /api/v1/todos/:id' do
    let!(:todo) { create(:todo, content: '削除するTODO') }
    it 'TODOを削除する' do
      expect do
        delete "/api/v1/todos/#{todo.id}"
        expect(response).to have_http_status(:no_content)
      end.to change(Todo, :count).by(-1)
    end
  end
end
