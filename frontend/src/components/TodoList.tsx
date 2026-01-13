import type { Todo } from '../typs/Todo'

type Props = {
  todos: Todo[]
}

const TodoList = ({ todos }: Props) => {
  return(
    <ul>
      {todos.map(todo => (
        <li key={todo.id}>
          {todo.attributes.content} - {todo.attributes.completed ? '完了' : '未完了'}
        </li>
      ))}
    </ul>
  )
}

export default TodoList
