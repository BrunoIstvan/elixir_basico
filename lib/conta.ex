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
                # grava no arquivo
                atualizar_contas(binary)
            # se a lista ja contem contas
            true -> 
                # verificar se ja existe conta cadastrada com esse email 
                c = buscar_conta_por_email(usuario.email)
                cond do
                    # se nao existir, concatenar o registro na lista
                    c == nil ->
                        binary = buscar_contas() ++ [%__MODULE__{usuario: usuario, saldo: 1000}]
                        # grava no arquivo
                        atualizar_contas(binary)
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

    defp executar_transferencia(de, para, valor) do
        # remove as contas de origem e destino
        contas = remover_contas([de, para])
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

    defp valida_de_para_contas(de, para) when(is_binary(de) and is_binary(para)) do
        # busca a conta de na lista de contas por email
        de = buscar_conta_por_email(de)
        para = buscar_conta_por_email(para)
        [de, para]
    end
    defp valida_de_para_contas(de, para) when(is_struct(de) and is_struct(para)) do
        # busca a conta de na lista de contas por struct
        de = buscar_conta_por_email(de.usuario.email)
        para = buscar_conta_por_email(para.usuario.email)
        [de, para]
    end

    def transferir(de, para, valor) do
        # recupera as contas
        [de, para] = valida_de_para_contas(de, para)
        cond do 
            # verifica se conta origem tem saldo
            valida_saldo(de.saldo, valor) -> {:error, "Saldo insuficiente!"}
            true -> executar_transferencia(de, para, valor)
        end
    end

    def sacar(conta, valor) when(is_binary(conta)) do
        conta = buscar_conta_por_email(conta)
        cond do 
            valida_saldo(conta.saldo, valor) -> {:error, "Saldo insuficiente!"}
            true -> executar_operacao(conta, conta.saldo - valor)
        end
    end
    def sacar(conta, valor) when(is_struct(conta)) do
        conta = buscar_conta_por_email(conta.usuario.email)
        cond do 
            valida_saldo(conta.saldo, valor) -> {:error, "Saldo insuficiente!"}
            true -> executar_operacao(conta, conta.saldo - valor)
        end
    end

    def depositar(conta, valor) when(is_binary(conta)) do
        # busca a conta por email
        conta = buscar_conta_por_email(conta)
        cond do 
            conta == nil -> {:error, "Conta não encontrada"}
            true -> executar_operacao(conta, conta.saldo + valor)
        end
    end
    def depositar(conta, valor) when(is_struct(conta)) do
        # busca a conta por struct
        conta = buscar_conta_por_email(conta.usuario.email)
        cond do 
            conta == nil -> {:error, "Conta não encontrada"}
            true -> executar_operacao(conta, conta.saldo + valor)
        end
    end

    defp executar_operacao(conta, valor) do
        # remove a conta que ira sacar da lista de contas 
        contas = remover_contas([conta])
        # faz o saque do valor
        conta = %Conta{conta | saldo: valor}
        # concatena as conta origem e destino na lista de contas
        contas = contas ++ [conta]
        # atualiza toda a lista de contas
        atualizar_contas(contas)
        # retorna conta
        conta
    end

    defp remover_contas(contas) do
        # remove as contas passadas por parametro da lista de contas retornadas do arquivo
        Enum.reduce(contas, buscar_contas(), fn c, acc -> List.delete(acc, c) end)
    end

    defp buscar_conta_por_email(email), do: Enum.find(buscar_contas(), &(&1.usuario.email == email))

    defp valida_saldo(saldo, valor), do: saldo < valor

end