defmodule Tabuada do
    
    def calcula(mult) when(is_integer(mult)) do
        tabuada(mult, 0)
    end
    
    defp tabuada(_, 11), do: []
    defp tabuada(mult, prod) do
        IO.puts("#{mult} x #{prod} = #{mult * prod} ")
        [mult * prod] ++ tabuada(mult, prod + 1)
    end

end