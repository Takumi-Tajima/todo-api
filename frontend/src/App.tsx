import { useEffect, useState } from 'react'
import './App.css'

type Todo = {
  id: string
  type: string
  attributes: {
    content: string
    completed: boolean
  }
}

function App() {
  const [todos, setTodos] = useState<Todo[]>([])

  useEffect(() => {
    fetch('http://localhost:3000/api/v1/todos')
      .then(response => response.json())
      .then(data => {
        console.log(data)
        setTodos(data.data)
      })
  }, [])

  return (
    <div>
      <h1>Todo List</h1>
      <p>取得件数: {todos.length}</p>
      <ul>
        {todos.map(todo => (
          <li key={todo.id}>
            {todo.attributes.content} - {todo.attributes.completed ? '完了' : '未完了'}
          </li>
        ))}
      </ul>
    </div>
  )
}

export default App
