export type Todo = {
  id: string
  type: string
  attributes: {
    content: string
    completed: boolean
  }
}
