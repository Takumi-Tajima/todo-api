require 'rails_helper'

RSpec.describe 'Api::V1::Todos', type: :request do
  describe 'GET /api/v1/todos' do
    before do
      create(:todo , content: 'サンプルTODO1')
      create(:todo , content: 'サンプルTODO2')
      create(:todo , content: 'サンプルTODO3')
    end
    it 'TODOリストを取得する' do
      get '/api/v1/todos'
      
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/todos/:id' do
    it '特定のTODOを取得する' do
      # todo = Todo.create!(title: 'サンプルTODO')
      # get "/api/v1/todos/#{todo.id}"
      # expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /api/v1/todos' do
    it 'TODOを作成する' do
      # post '/api/v1/todos', params: { todo: { title: '新しいTODO' } }
      # expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /api/v1/todos/:id' do
    it 'TODOを更新する' do
      # todo = Todo.create!(title: 'サンプルTODO')
      # put "/api/v1/todos/#{todo.id}", params: { todo: { title: '更新されたTODO' } }
      # expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /api/v1/todos/:id' do
    it 'TODOを削除する' do
      # todo = Todo.create!(title: 'サンプルTODO')
      # delete "/api/v1/todos/#{todo.id}"
      # expect(response).to have_http_status(:no_content)
    end
  end
end
