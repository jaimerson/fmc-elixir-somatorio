defmodule FMCTest do
  use ExUnit.Case
  use ExCheck


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

  property "soma de somatório = somatório da soma" do
    for_all {x, y} in {int, int} do
      summation_of_sum = FMC.somatorio(x, fn(a) -> a + y end)
      sum_of_summation = FMC.somatorio(x, &(&1)) + FMC.somatorio(x, fn(_) -> y end)
      summation_of_sum == sum_of_summation
    end
  end

  property "subtração de somatório = somatório da subtração" do
    for_all {x, y} in {int, int} do
      subtraction_of_sum = FMC.somatorio(x, fn(a) -> a - y end)
      sum_of_subtraction = FMC.somatorio(x, &(&1)) - FMC.somatorio(x, fn(_) -> y end)
      subtraction_of_sum == sum_of_subtraction
    end
  end

  property "ajuste de índices" do
    for_all {m, n} in {int, int} do
      summation_one = FMC.somatorio(m, n, fn(i) -> i + 1 end)
      summation_two = FMC.somatorio(m + 1, n + 1, fn(i) -> i end)
      summation_one == summation_two
    end
  end

  property "combinação de somatórios" do
    for_all {s, t, j} in {int, int, int} do
      implies s < j and j < t do
        first_part = FMC.somatorio(s, j, &(&1))
        second_part = FMC.somatorio(j + 1, t, &(&1))
        whole = FMC.somatorio(s, t, &(&1))
        whole == first_part + second_part
      end
    end
  end
end
