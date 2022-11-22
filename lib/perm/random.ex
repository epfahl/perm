defmodule Perm.Random do
  @doc """
  Run
  [Durstenfeld's version](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_modern_algorithm)
  of the Fisher-Yates shuffle. This implementation uses a Erlang Array to hold and
  efficiently manipulate the list of items in place.

  ```elixir
  Perm.Random.shuffle([1, 2, 3])
  [2, 1, 3]   # example return

  Perm.Random.run([])
  []
  ```
  """
  def shuffle([_ | _] = items) do
    a = from_list_fixed(items)
    size = :array.size(a)

    Enum.reduce((size - 1)..1, a, fn i, acc ->
      j = :rand.uniform(i + 1) - 1
      swap(acc, i, j)
    end)
    |> :array.to_list()
  end

  def shuffle([]), do: []

  defp swap(a, i, j) do
    temp = :array.get(i, a)
    a = :array.set(i, :array.get(j, a), a)
    :array.set(j, temp, a)
  end

  defp from_list_fixed(items) do
    items |> :array.from_list() |> :array.fix()
  end
end
