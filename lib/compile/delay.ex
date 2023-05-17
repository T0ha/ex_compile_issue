defmodule Compile.Delay do
  defmacro gen_delay do
    :timer.sleep(10000)
    mod = 
      __MODULE__
      |> Module.concat("Require")
    
    quote do
      defmodule unquote(mod) do
        def hello(), do: "world"
      end
    end
  end
end
