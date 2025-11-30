from MainProgram.src.controllers import screenController as sc
from MainProgram.objects import research as res
from MainProgram.src.connections import connection as con
import psycopg2

# -----------------------------------------------------
# LISTA PESQUISAS DA PESSOA LOGADA
# -----------------------------------------------------
# - Faz um SELECT para trazer diversas informações
# - Transforma em uma lista do objeto Pesquisa
# - Passa essa lista para uma função que printa essas pesquisas
# -----------------------------------------------------
def MinhasPesquisas(idPerson):
    
    sc.Header(4)

    try:
        
        connection, cursor = con.GetConnectionAndCursor()

        cursor.execute("""

            SELECT PE.data_ingresso, PE.data_saida, E.TITULO, E.AREA, E.DATA_CRIACAO, P.descricao, U.NOME AS Universidade, A.NOME AS AgenciaFomento, F.VALOR AS ValorFinanciado
            FROM Pesq_Exec PE 
            JOIN Execucao E
                ON pe.ID_Exec = e.ID
            JOIN Universidade u 
                ON e.CNPJ = u.CNPJ
            JOIN pesquisa p 
            	ON E.titulo = P.titulo 
            	and E.area  = P.area 
            	and E.data_criacao = P.data_criacao 
            LEFT JOIN Financia f 
                ON E.titulo  	  = f.Titulo
                AND E.AREA 		  = f.Area
                AND E.data_criacao = f.data_criacao 
            LEFT JOIN Ag_Fomento a
                ON f.CNPJ = a.CNPJ
            WHERE pe.ID_Pesq = %s;
        """, [idPerson])

        result = cursor.fetchall()
        cursor.close()

        pesquisas = [
            res.Pesquisa(
                idPesq = idPerson,
                titulo=row[2],
                area=row[3],
                dtCriacao=row[4],
                descricao=row[5],
                universidade=row[6],
                agFomento=row[7],
                valor=row[8],
                dtEntrada=row[0],
                dtSaida=row[1]
            )

            for row in result
        ]

        sc.ListarPesquisas(pesquisas, idPerson)

    except psycopg2.Error as error:
        connection.rollback()
        print("Erro:", error)

        input("Parece que algo deu errado... Pressione qualquer tecla para sair... ")
        sc.Menu(idPerson)
   
# -----------------------------------------------------
# TELA PARA BUSCAR POR AREA
# -----------------------------------------------------
# - Pega a entrada do usuario da area
# - Faz um select das informações relevantes
# - Monta uma lista de pesquisas com os resultados
    # - Lista todas as pesquisas
# -----------------------------------------------------
def BuscarPorArea(idPerson):

    sc.Header(5)
    area = input("Area: ").upper()

    try:
        connection, cursor = con.GetConnectionAndCursor()
        cursor.execute("""
            SELECT E.TITULO, E.AREA, E.DATA_CRIACAO, P.descricao, U.NOME AS Universidade, A.NOME AS AgenciaFomento, F.VALOR AS ValorFinanciado
FROM EXECUCAO E
JOIN Universidade u 
                ON e.CNPJ = u.CNPJ
            join pesquisa p 
            	on E.titulo = P.titulo 
            	and E.area  = P.area 
            	and E.data_criacao = P.data_criacao 
            left JOIN Financia f 
                on E.titulo  	  = f.Titulo
                AND E.AREA 		  = f.Area
                AND E.data_criacao = f.data_criacao 
            left JOIN Ag_Fomento a
                ON f.CNPJ = a.CNPJ
            WHERE E.AREA = %s;
        """, [area])

        result = cursor.fetchall()
        cursor.close()

        pesquisas = [
            res.Pesquisa(
                idPesq = idPerson,
                titulo=row[0],
                area=row[1],
                dtCriacao=row[2],
                descricao=row[3],
                universidade=row[4],
                agFomento=row[5],
                valor=row[6],
                dtEntrada=None,
                dtSaida=None
            )

            for row in result
        ]

        sc.ListarPesquisas(pesquisas, idPerson)

    except psycopg2.Error as error:
        connection.rollback()
        print("Erro:", error)
        input("Parece que algo deu errado... Pressione qualquer tecla para sair... ")
        sc.Menu(idPerson)
   
# -----------------------------------------------------
# TELA PARA ADICIONAR PESQUISA 
# -----------------------------------------------------
# - Recolhe todos os dados de uma pesquisa
# - Adiciona esses dados com um INSERT
# -----------------------------------------------------
def AdicionarPesquisa(idPerson):

    sc.Header(6)
    
    print("Adicione as seguintes informações:\n")
    print("-------------------------------")

    try:
        
        connection, cursor = con.GetConnectionAndCursor() 

        titulo = input("Titulo: ").upper()
        area = input("Área: ").upper()
        dtCriacao = input("Data de Criação (dd/mm/yyyy): ").strip()
        desc = input("Descrição: ").upper()

        cursor.execute("""
            INSERT INTO PESQUISA (DATA_CRIACAO, TITULO, AREA, DESCRICAO)
            VALUES (TO_DATE(%s, 'DD/MM/YYYY'), %s, %s, %s)
        """, [dtCriacao, titulo, area, desc])

        print("-------------------------------")

        universidade = input("CNPJ da Universidade: ") or None

        if(universidade == None):
            print("ERRO: você não pode deixar o campo universidade vazio...")
            input("Pressione qualquer tecla para voltar")
            sc.Menu(idPerson)

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
        print("Todos os valores foram adicionados ao banco de dados...")
        sc.Esperar(1.5)
        sc.Menu(idPerson)

    except psycopg2.Error as error:
        connection.rollback()
        print("Erro:", error)
        input("Parece que algo deu errado... Pressione qualquer tecla para sair... ")
        sc.Menu(idPerson)
   


def BuscasRefinadas(idPerson):
    sc.Header(7)
    print("\nQual Informação você deseja saber?\n")
    print("----------------------------------\n")
    print("[1] Pesquisas financiadas sem execução associada")
    print("[2] Pesquisas com número de amostras acima da média geral")
    print("[3] Hospitais que receberam amostras de TODAS as pesquisas financiadas por uma agência específica")
    print("[4] Agências que financiam pesquisas executadas em hospitais onde nenhuma outra agência tem pesquisas")
    print("[5] Hospitais que receberam amostras ligadas a pesquisas financiadas por >1 agência")
    print()

    opcao = None
    while opcao not in (1, 2, 3, 4, 5):
        try:
            opcao = int(input("Opção: ").strip())
        except ValueError:
            print("Entrada inválida — digite um número entre 1 e 5.\n")

    # ==================== SE A OPÇÃO FOR 3 ========================
    agencia_id_escolhida = None
    if opcao == 3:
        print("\n=== Agências de Fomento Disponíveis ===")
        cursor.execute("SELECT cnpj, nome FROM AG_FOMENTO ORDER BY nome;")
        agencias = cursor.fetchall()
        for cnpj, nome in agencias:
            print(f"{cnpj} — {nome}")

        print("\nEscolha o CNPJ da agência desejada:")
        while agencia_id_escolhida is None:
            entrada = input("CNPJ: ").strip()
            if any(entrada == str(a[0]) for a in agencias):
                agencia_id_escolhida = entrada
            else:
                print("CNPJ inválido. Digite exatamente como mostrado acima.\n")

    # -------------------- QUERIES PRONTAS --------------------
    queries = {
        1: """
            SELECT 
                ag.nome,
                f.data_criacao,
                f.titulo,
                f.area,
                f.valor
            FROM FINANCIA f
            JOIN AG_FOMENTO ag ON ag.cnpj = f.cnpj
            LEFT JOIN EXECUCAO e
                ON e.data_criacao = f.data_criacao
               AND e.titulo       = f.titulo
               AND e.area         = f.area
            WHERE e.id IS NULL
            ORDER BY f.data_criacao;
        """,

        2: """
            WITH pesquisa_amostras AS (
                SELECT
                    p.id_pesquisa,
                    COUNT(eda.id_amostra) AS total_amostras
                FROM PESQUISA p
                LEFT JOIN EXECUCAO e
                       ON e.data_criacao = p.data_criacao
                      AND e.titulo       = p.titulo
                      AND e.area         = p.area
                LEFT JOIN EXEC_DISP_AMOSTRA eda
                       ON eda.id_exec = e.id
                GROUP BY p.id_pesquisa
            ),
            media_geral AS (
                SELECT AVG(total_amostras) AS media
                FROM pesquisa_amostras
            )
            SELECT pa.*
            FROM pesquisa_amostras pa, media_geral mg
            WHERE pa.total_amostras > mg.media;
        """,

        # =================== QUERY 3 (DINÂMICA) ===================
        3: f"""
            WITH pesquisas_agencia AS (
                SELECT f.data_criacao, f.titulo, f.area
                FROM FINANCIA f
                WHERE f.cnpj = '{agencia_id_escolhida}'
            ),
            amostras_pesquisas AS (
                SELECT DISTINCT
                    p.data_criacao,
                    p.titulo,
                    p.area,
                    da.id_estab AS id_hospital
                FROM pesquisas_agencia p
                JOIN EXECUCAO e
                  ON e.data_criacao = p.data_criacao
                 AND e.titulo       = p.titulo
                 AND e.area         = p.area
                JOIN DISPONIBILIZACAO dis ON dis.id_exec = e.id
                JOIN DADOS_AMOSTRA da    ON da.id = dis.id_dados
            )
            SELECT h.id AS id_hospital, h.nome
            FROM ESTAB_SAUDE h
            WHERE NOT EXISTS (
                SELECT 1
                FROM pesquisas_agencia pa
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM amostras_pesquisas ap
                    WHERE ap.id_hospital = h.id
                      AND ap.data_criacao = pa.data_criacao
                      AND ap.titulo = pa.titulo
                      AND ap.area   = pa.area
                )
            )
            ORDER BY h.nome;
        """,

        4: """
            WITH hospital_agencias AS (
                SELECT DISTINCT
                    est.id        AS hospital_id,
                    f.cnpj        AS agencia_cnpj
                FROM HOSPITAL_CLINICA h
                JOIN ESTAB_SAUDE est ON est.id = h.id
                JOIN DADOS_AMOSTRA da ON da.id_estab = est.id
                JOIN DISPONIBILIZACAO dis ON dis.id_dados = da.id
                JOIN EXECUCAO e ON e.id = dis.id_exec
                JOIN FINANCIA f
                  ON f.data_criacao = e.data_criacao
                 AND f.titulo       = e.titulo
                 AND f.area         = e.area
            ),
            hospitais_unica_agencia AS (
                SELECT hospital_id
                FROM hospital_agencias
                GROUP BY hospital_id
                HAVING COUNT(DISTINCT agencia_cnpj) = 1
            )
            SELECT DISTINCT ha.agencia_cnpj AS cnpj, ag.nome
            FROM hospital_agencias ha
            JOIN hospitais_unica_agencia hua 
                  ON hua.hospital_id = ha.hospital_id
            JOIN AG_FOMENTO ag ON ag.cnpj = ha.agencia_cnpj
            ORDER BY ag.nome;
        """,

        5: """
            SELECT 
                est.nome AS nome_hospital,
                COUNT(DISTINCT f.cnpj) AS n_agencias_distintas
            FROM HOSPITAL_CLINICA h
            JOIN ESTAB_SAUDE est ON est.id = h.id
            JOIN DADOS_AMOSTRA da ON da.id_estab = est.id
            JOIN DISPONIBILIZACAO dis ON dis.id_dados = da.id
            JOIN EXECUCAO e ON e.id = dis.id_exec
            JOIN FINANCIA f
              ON f.data_criacao = e.data_criacao
             AND f.titulo       = e.titulo
             AND f.area         = e.area
            GROUP BY est.nome
            HAVING COUNT(DISTINCT f.cnpj) > 1
            ORDER BY n_agencias_distintas DESC, est.nome;
        """
    }

    # -------------------- EXECUTA A QUERY ESCOLHIDA --------------------
    sql = queries[opcao]

    try:
        connection, cursor = con.GetConnectionAndCursor() 
        cursor.execute(sql)
        resultados = cursor.fetchall()

        print("\n===== RESULTADOS =====\n")
        for linha in resultados:
            print(linha)
        print("\n=======================\n")

        cursor.close()
        input("Pressione qualquer tecla para sair... ")
        sc.Menu(idPerson)

    except Exception as e:
            connection.rollback()
            print("Erro:", e)
            input("Parece que algo deu errado... Pressione qualquer tecla para sair... ")
            sc.Menu(idPerson)

