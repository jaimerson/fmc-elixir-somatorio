defmodule FMCTest do
  use ExUnit.Case
  use ExCheck
  alias ExCheck.Sample


  property "caso base" do
    for_all x in int do
      FMC.somatorio(x, x, &(&1)) == x
    end
  end

  property "caso recursivo" do
    for_all {x, y} in {int, int} do
      FMC.somatorio(x, y, &(&1)) == Enum.reduce(x..y, &(&1 + &2))
    end
  end

  property "multiplicação por constante" do
    for_all {x, y} in {int, int} do
      FMC.somatorio(x, &(&1 * y)) == y * FMC.somatorio(x, &(&1))
    end
  end
end
