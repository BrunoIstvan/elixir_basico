defmodule MeuModulo.Tabuada do
    
    def tabuada(mult) do
        tabuada(mult, 0, [])
    end
    
    defp tabuada(_, 11, lista), do: lista
    defp tabuada(mult, prod, lista) do
        IO.puts("#{mult} x #{prod} = #{mult * prod} ")
        lista = lista ++ [mult * prod]
        tabuada(mult, prod + 1, lista)
    end

end