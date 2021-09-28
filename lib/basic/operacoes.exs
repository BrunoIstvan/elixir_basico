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

        def zero?(0), do: true
        def zero?(x) when(is_integer(x)), do: false

        def soma_pares_multiplos_5(lista) do
            require Integer
            lista 
            |>Enum.map(&(&1 * 5))
            |>Enum.filter(&Integer.is_even(&1))
            |>Enum.sum()
        end

end