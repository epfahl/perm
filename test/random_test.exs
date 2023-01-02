defmodule RandomTest do
  use ExUnit.Case
  doctest Perm.Random

  alias Perm.Random
  alias Perm.Validation

  test "shuffle of an empty list is an empty list" do
    assert Random.shuffle([]) == []
  end

  test "shuffle of a permutation is a valid permutation" do
    items = [:a, :b, :c, :d]
    perm = Random.shuffle(items)

    assert {:ok, _} = Validation.validate(perm, items)
  end
end
