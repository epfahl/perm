defmodule Perm.Lehmer do
  @moduledoc """
  Lehmer encoding of permutations, and corresponding decoding.

  The implementations of encoding and decoding follow the in-place algorithms described
  [here](https://en.wikipedia.org/wiki/Lehmer_code#Encoding_and_decoding)
  """

  @doc """
  Return the Lehmer encoding of the given permuation of 0..n-1.
  """
  def encode([_ | _] = perm) do
    with {:ok, perm} <- validate(perm) do
      do_encode([], perm)
    end
  end

  def encode([]), do: []

  defp do_encode(acc, [v | right]) do
    u = dec_right(v, right)
    do_encode([v | acc], u)
  end

  defp do_encode(acc, []), do: acc |> Enum.reverse()

  defp dec_right(v, acc) do
    for x <- acc, do: if(v < x, do: x - 1, else: x)
  end

  @doc """
  Return the permutation of 0..n-1 corresponding to the given Lehmer code.
  """
  def decode([_ | _] = code) do
    perm = do_decode([], code |> Enum.reverse())

    with {:ok, perm} <- validate(perm) do
      perm
    end
  end

  def decode([]), do: []

  defp do_decode(acc, [h | t]) do
    u = inc_left(h, acc)
    do_decode([h | u], t)
  end

  defp do_decode(acc, []), do: acc

  defp inc_left(v, acc) do
    for x <- acc, do: if(v <= x, do: x + 1, else: x)
  end

  defp validate(perm) do
    items = 0..(length(perm) - 1) |> Enum.to_list()

    Perm.Validation.validate(perm, items)
  end
end
