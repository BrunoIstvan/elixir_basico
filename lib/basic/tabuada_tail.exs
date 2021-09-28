defmodule Tabuada do
    
    def calcula(mult) when(is_integer(mult)) do
        calcula(mult, 0, [])
    end
    
    defp calcula(_, 11, valores), do: valores
    defp calcula(mult, prod, valores) do
        IO.puts("#{mult} x #{prod} = #{mult * prod} ")
        novos_valores = valores ++ [mult * prod]
        calcula(mult, prod + 1, novos_valores)
    end

end