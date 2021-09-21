defmodule Conta do

    defstruct usuario: Usuario, saldo: nil
    @contas "contas.txt"

    def atualizar_contas(contas) do
        binary = contas
        # converte termo para binario
        |> :erlang.term_to_binary()
        # grava no arquivo
        File.write(@contas, binary)
    end


    def cadastrar(usuario) do
    
        # busca as contas do arquivo
        contas_lista = buscar_contas()

        cond do 
            # se a lista de contas esta vazia, criar um registro 
            contas_lista == nil -> 
                binary = [%__MODULE__{usuario: usuario, saldo: 1000}]
                # converte termo para binario
                |> :erlang.term_to_binary()
                # grava no arquivo
                File.write(@contas, binary)
            # se a lista ja contem contas
            true -> 
                # verificar se ja existe conta cadastrada com esse email 
                c = buscar_conta_por_email(usuario.email)
                cond do
                    # se nao existir, concatenar o registro na lista
                    c == nil ->
                        binary = [%__MODULE__{usuario: usuario, saldo: 1000}] ++ buscar_contas()
                        # converte termo para binario
                        |> :erlang.term_to_binary()
                        # grava no arquivo
                        File.write(@contas, binary)
                    # se existir, retornar erro
                    true -> {:error, "Usuário já cadastrado!"}

                end
        end

    end

    def buscar_contas do

        # le o conteudo do arquivo
        {result, binary} = File.read(@contas)
        cond do 
            # se o arquivo nao existe, enviara um error e retornaremos nil
            result == :error -> nil
            # se o arquivo estiver vazio, retornaremos nil
            binary == "" -> nil
            # converte o conteudo de binario para termo
            true -> :erlang.binary_to_term(binary)
        end
        
    end

    def transferir(de, para, valor) do

        # busca a conta de na lista de contas
        de = buscar_conta_por_email(de.usuario.email)
        para = buscar_conta_por_email(para.usuario.email)
                
        cond do 
            # verifica se conta origem existe
            de == nil -> {:error, "Conta origem não existe"}
            para == nil -> {:error, "Conta destino não existe"}
            # verifica se conta origem tem saldo
            valida_saldo(de.saldo, valor) -> {:error, "Saldo insuficiente!"}
            true -> 
                # busca as contas
                contas = buscar_contas()
                # remove a conta origem
                contas = List.delete contas, de
                # remove a conta destino
                contas = List.delete contas, para
                # calcula transferencia e atualiza o saldo das contas de origem e destino
                de = %Conta{de | saldo: de.saldo - valor}
                para = %Conta{para | saldo: para.saldo + valor}
                # concatena as conta origem e destino na lista de contas
                contas = contas ++ [de, para]
                # atualiza toda a lista de contas
                atualizar_contas(contas)
                # retorna
                [de, para]
        end

    end

    def sacar(conta, valor) do

        cond do 
            valida_saldo(conta.saldo, valor) -> {:error, "Saldo insuficiente!"}
            true -> 
                # busca as contas
                contas = buscar_contas()
                # remove a conta que ira sacar da lista de contas 
                contas = List.delete contas, conta
                # faz o saque do valor
                conta = %Conta{conta | saldo: conta.saldo - valor}
                # concatena as conta origem e destino na lista de contas
                contas = contas ++ [conta]
                # atualiza toda a lista de contas
                atualizar_contas(contas)
                # retorna conta
                conta
        end

    end

    defp buscar_conta_por_email(email), do: Enum.find(buscar_contas(), &(&1.usuario.email == email))

    defp valida_saldo(saldo, valor), do: saldo < valor

end