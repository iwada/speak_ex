defmodule SpeakEx.Utils do

  def any_to_charlist(string) when is_binary(string),
    do: String.to_charlist(string)

  def any_to_charlist(list) when is_list(list),
    do: list

  def any_to_charlist(int) when is_integer(int),
    do: Integer.to_charlist(int)

  def get_channel_variable(call, variable, default \\ nil)

  def get_channel_variable(call, variable, default) when is_binary(variable),
    do: get_channel_variable(call, String.to_charlist(variable), default)

  def get_channel_variable(call, variable, default) when is_atom(variable),
    do: get_channel_variable(call, Atom.to_charlist(variable), default)

  def get_channel_variable(call, variable, default) do
    var = translate_channel_variable variable
    list = elem call, 1
    case List.keyfind list, 'agi_' ++ var, 0 do
      nil -> default
      {_, value} ->
        value |> List.to_string
    end
  end

  def translate_channel_variable(var) when var in [:to, :from],
    do: translate_channel_variable(Atom.to_charlist var)

  def translate_channel_variable('to'),
    do: 'extension'

  def translate_channel_variable('from'),
    do: 'callerid'

  def translate_channel_variable(other),
    do: other

end
