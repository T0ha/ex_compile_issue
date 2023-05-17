defmodule Compile.Delay do
  defmacro gen_delay do
    :timer.sleep(10000)
    mod = 
      __MODULE__
      |> Module.concat("Require")

    modules = 
      ?A..?Z
      |> Stream.map(fn letter ->
        module = Module.concat(mod, "#{[letter]}")

        quote do
          defmodule unquote(module) do
            def hello(), do: "world"
          end
        end

      end)
      |> Enum.reduce(quote do end, fn macro, acc ->
        :timer.sleep(1000)
        quote do
          unquote(acc)
          unquote(macro)
        end
      end)

    quote do
      unquote(modules)
    end
end
  end
