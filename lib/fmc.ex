defmodule FMC do
  def somatorio(start \\ 0, finish, callback) do
    Enum.reduce(start..finish, fn(element, accumulator) ->
      accumulator + callback.(element)
    end)
  end
end
