defmodule MeuModulo.Math do

        def soma(p1, p2), do: p1 + p2

        def subtrai(p1, p2), do: p1 - p2

        def multiplica(p1, p2), do: p1 * p2

        def divide(p1, p2), do: p1 / p2

        def multiplica_lista_por_2(lista) do
                Enum.map(lista, fn (n) -> n * 2 end)
        end

        def multiplica_lista_por_2_v2(lista) do
                Enum.map(lista, &(&1 * 2))
        end

end