defmodule MeuModulo do
    import IO, only: [puts: 1]
    import Kernel, except: [inspect: 1]

    alias MeuModulo.Math, as: MeuMath

    def ola_mundo do
        inspect(MeuMath.multiplica(56, 23))
    end

    def exibe_se_eh_par(numero) do
        require Integer
        puts("O número #{numero} é par? #{Integer.is_even(numero)}")

    end

    defp inspect(parametro) do
        puts("Começando a inspeção")
        puts(parametro)
        puts("Terminando a inspeção")
    end

end