type Props = {
  content: string
  onChangeContent: (e: React.ChangeEvent<HTMLInputElement>) => void
  onSubmit: (e: React.FormEvent) => void
}

const TodoForm = ({ content, onChangeContent, onSubmit }: Props) => {
  return (
    <form onSubmit={onSubmit}>
      <input type="text" value={content} onChange={onChangeContent} />
      <button type="submit">追加</button>
    </form>
  )
}

export default TodoForm
