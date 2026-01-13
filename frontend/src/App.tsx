import { useEffect, useState } from 'react'
import type { Todo } from './typs/Todo'
import TodoList from './components/TodoList'
import './App.css'

function App() {
  const [todos, setTodos] = useState<Todo[]>([])
  const [newTodoContent, setNewTodoContent] = useState('')

  const changeNewTodoContent = (e: React.ChangeEvent<HTMLInputElement>) => setNewTodoContent(e.target.value)
  const handleNewTodoSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    console.log('新しいTodoの内容:', newTodoContent)
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
      {/* TODOを追加するフォーム */}
      <form onSubmit={handleNewTodoSubmit}>
        <input type="text" value={newTodoContent} onChange={changeNewTodoContent} />
        <button type="submit">追加</button>
      </form>
    </div>
  )
}

export default App
