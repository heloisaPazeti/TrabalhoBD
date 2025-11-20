from MainProgram.src.controllers import screenController as sc
from MainProgram.objects import research as res
from MainProgram.src.connections import connection as con
import psycopg2

# -----------------------------------------------------
# LISTA PESQUISAS DA PESSOA LOGADA
# -----------------------------------------------------
def MinhasPesquisas():
    
    sc.Header(4)
    listaPesquisas = tc.DummyPesquisas()
    result = sc.ListarPesquisas(listaPesquisas)

    if(result):
        sc.MinhasPesquisas()

# -----------------------------------------------------
# TELA DE OPÇÕES DE BUSCA
# -----------------------------------------------------
def Buscar():

    sc.Header(5)

    print("Opções de Busca:")
    print("[1] - Titulo")
    print("[2] - Pesquisador")
    print("[3] - Universidade")
    print("[4] - Area")
    print("[5] - Data de Criação")
    print("[6] - Área")
    print("[7] - Agência de Fomento")

    print("-------------------------------")
    print("[0] - Voltar")
    print("-------------------------------")
    opt = int(input("Selecione uma opção: "))
    print("-------------------------------")

    if(opt == 0):
        sc.Menu()
    else:
        query = input("Escreva Busca: ")
        # Aqui vai ter que fazer checagens para saber se a busca é válida ou não
        # Depois fazer a busca
        #result = sr.ListarPesquisas(listaPesquisas)
        #if(result):
            #Buscar()
        sc.Menu()

# -----------------------------------------------------
# TELA PARA ADICIONAR PESQUISA 
# -----------------------------------------------------
def AdicionarPesquisa():

    sc.Header(6)
    
    print("Adicione as seguintes informações:\n")
    print("-------------------------------")

    try:
        
        connection, cursor = con.GetConnectionAndCursor() 

        titulo = input("Titulo: ")
        area = input("Área: ")
        dtCriacao = input("Data de Criação (dd/mm/yyyy): ").strip()
        desc = input("Descrição: ")

        cursor.execute("""
            INSERT INTO PESQUISA (DATA_CRIACAO, TITULO, AREA, DESCRICAO)
            VALUES (TO_DATE(%s, 'DD/MM/YYYY'), %s, %s, %s)
        """, [dtCriacao, titulo, area, desc])

        print("-------------------------------")

        universidade = input("CNPJ da Universidade: ")
        dtInicio = input("Data de Inicio da Execução (dd/mm/yyyy): ")
        dtConclusao = input("Data de Conclusão da Execução (dd/mm/yyyy): ")

        cursor.execute("""
            INSERT INTO EXECUCAO (DATA_CRIACAO, TITULO, AREA, CNPJ, DATA_INICIO, DATA_CONCLUSAO) 
            VALUES (TO_DATE(%s, 'DD/MM/YYYY'), %s, %s, %s, TO_DATE(%s, 'DD/MM/YYYY'), TO_DATE(%s, 'DD/MM/YYYY'))
            RETURNING ID;
        """, [dtCriacao, titulo, area, universidade, dtInicio, dtConclusao])
        idExec = cursor.fetchone()[0]

    
        print("-------------------------------")

        qtdePesq = int(input("Quantos pesquisadores comuns irão participar: "))

        while(qtdePesq != 0):
            idPesq = input("ID pesquisador: ")
            dtIngresso = input ("Data de Inicio do pesquisador (dd/mm/yyyy): ")
            dtSaida = input("Data de Conclusao do pesquisador (dd/mm/yyyy): ")
            cursor.execute("""
                INSERT INTO PESQ_EXEC (ID_PESQ, ID_EXEC, DATA_INGRESSO, DATA_SAIDA)
                VALUES (%s, %s, TO_DATE(%s, 'DD/MM/YYYY'), TO_DATE(%s, 'DD/MM/YYYY'));
            """, [idPesq, idExec, dtIngresso, dtSaida])

            qtdePesq = qtdePesq - 1

        print("-------------------------------")
    
        financiamento = input("Será financiado? [s/n]: ")
        if financiamento == "s":
            agFomento = input("CNPJ da Ag. de Fomento: ")
            valor = input("Valor do Financiamento: ")

            cursor.execute("""
                INSERT INTO FINANCIA (CNPJ, DATA_CRIACAO, TITULO, AREA, VALOR)
                VALUES (%s, TO_DATE(%s, 'DD/MM/YYYY'), %s, %s, %s);
            """, [agFomento, dtCriacao, titulo, area, valor])
        
        connection.commit()
        cursor.close()
        sc.Esperar(1)
        sc.Menu()

    except psycopg2.Error as error:
        connection.rollback()
        print("Erro:", error)

        input("Parece que algo deu errado... Pressione qualquer tecla para sair... ")
        sc.Menu()
    #pesquisa = res.Pesquisa(titulo, area, dtCriacao, universidade, agFomento, pesqResponsa, pesqs, desc)
   

