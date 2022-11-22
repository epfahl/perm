defmodule Perm.Validation do
  @doc """
  Validate the the given list is a permutation of 0..n-1.
  """
  def validate(perm, items) when is_list(perm) and is_list(items) do
    test =
      Enum.all?([
        validate_lengths_equal(perm, items),
        validate_sets_equal(perm, items)
      ])

    if test do
      {:ok, perm}
    else
      {:error, "invalid permuation #{inspect(perm)} of items #{inspect(items)}"}
    end
  end

  defp validate_lengths_equal(perm, items), do: length(perm) == length(items)

  defp validate_sets_equal(perm, items), do: MapSet.new(perm) == MapSet.new(items)
end
