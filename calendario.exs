defmodule MeuModulo.Calendario do

    def abreviacao_dia_semana(dia_semana) do

        case dia_semana do
            :Segunda -> "Seg"
            :Terca -> "Ter"
            :Quarta -> "Qua"
            :Quinta -> "Qui"
            :Sexta -> "Sex"
            :Sabado -> "Sab"
            :Domingo -> "Dom"
            _ -> "Dia inválido"
        end
    end

    def abreviacao_dia_semana2(dia_semana) do

        cond do
            dia_semana == :Segunda -> "Seg"
            dia_semana == :Terca -> "Ter"
            dia_semana == :Quarta -> "Qua"
            dia_semana == :Quinta -> "Qui"
            dia_semana == :Sexta -> "Sex"
            dia_semana == :Sabado -> "Sab"
            dia_semana == :Domingo -> "Dom"
            true -> "Dia inválido"
        end
    end

    def abreviacao_dia_semana3(:Segunda), do: "Seg" 
    def abreviacao_dia_semana3(:Terca), do: "Ter" 
    def abreviacao_dia_semana3(:Quarta), do: "Qua" 
    def abreviacao_dia_semana3(:Quinta), do: "Qui" 
    def abreviacao_dia_semana3(:Sexta), do: "Sex" 
    def abreviacao_dia_semana3(:Sabado), do: "Sab" 
    def abreviacao_dia_semana3(:Domingo), do: "Dom" 
    def abreviacao_dia_semana3(_), do: "Dia inválido" 

end