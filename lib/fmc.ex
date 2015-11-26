defmodule FMC do
  def somatorio(start \\0, finish, callback)

  def somatorio(start, finish, callback) when start == finish do
    callback.(start)
  end

  def somatorio(start, finish, callback) do
    _somatorio(Enum.to_list(start..finish), callback)
  end

  defp _somatorio([], _), do: 0
  defp _somatorio([head | tail], callback) do
    callback.(head) + _somatorio(tail, callback)
  end
end
