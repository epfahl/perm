defmodule LehmerTest do
  use ExUnit.Case
  doctest Perm.Lehmer

  alias Perm.Lehmer

  test "encode empty permutation" do
    assert Lehmer.encode([]) == []
  end

  test "decode empty code" do
    assert Lehmer.decode([]) == []
  end

  test "decoded encoding equals permutation" do
    perm = [1, 5, 0, 6, 3, 4, 2]
    code = Lehmer.encode(perm)

    assert Lehmer.decode(code) == perm
  end
end
