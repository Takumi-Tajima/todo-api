import { useEffect, useState } from 'react'
import type { Todo } from './typs/Todo'
import TodoList from './components/TodoList'
import TodoForm from './components/TodoForm'
import './App.css'

function App() {
  const [todos, setTodos] = useState<Todo[]>([])
  const [newTodoContent, setNewTodoContent] = useState('')

  const changeNewTodoContent = (e: React.ChangeEvent<HTMLInputElement>) => setNewTodoContent(e.target.value)
  const handleNewTodoSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    
    if (!newTodoContent) return

    fetch('http://localhost:3000/api/v1/todos', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ todo: { content: newTodoContent }})
    })
    .then(response => response.json())
    .then(data => {
      setTodos([...todos, data.data])
      setNewTodoContent('')
    })
  }

  useEffect(() => {
    fetch('http://localhost:3000/api/v1/todos')
      .then(response => response.json())
      .then(data => {
        setTodos(data.data)
      })
  }, [])

  return (
    <div>
      <h1>Todo List</h1>
      <p>取得件数: {todos.length}</p>
      <TodoList todos={todos} />
      <TodoForm
        content={newTodoContent}
        onChangeContent={changeNewTodoContent}
        onSubmit={handleNewTodoSubmit}
      />
    </div>
  )
}

export default App
