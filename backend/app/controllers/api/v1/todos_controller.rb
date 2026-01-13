class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: %i[show update destroy]

  def index
    @todos = Todo.default_order
    render json: TodoSerializer.new(@todos)
  end

  def show
    render json: TodoSerializer.new(@todo)
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: TodoSerializer.new(@todo), status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    @todo = Todo.find(params.expect(:id))
  end

  def todo_params
    params.expect(todo: %i[content])
  end
end
