
from MainProgram.src.controllers import screenController as sc

# APENAS PARA TESTE
from MainProgram.src.functions import testCredentials as tc

def Cadastrar():
    result = True
    sc.Header(2)

    cpf = input("CPF: ").strip()
    name = input("Nome: ")
    uf = input("UF: ").strip()
    cidade = input("Cidade: ")
    bairro = input("Bairro: ")
    rua = input("Rua: ")
    nro = input("Numero: ")
    telefone1 = input("Telefone Principal: ")
    telefone2 = input("Telefone Secundario (opcional): ") or None
    dtNasc = input("Data de Nascimento (dd/mm/yyyy): ").strip()
    
    coren = input("COREN (opcional, digite 'nulo' para deixar vazio): ")
    crm = input("CRM (opcional, digite 'nulo' para deixar vazio): ")

    coren = None if coren.lower() == "nulo" else coren
    crm = None if crm.lower() == "nulo" else crm

    senha = input("Senha: ")
    senha2 = input("Insira a senha novamente: ")

    while senha != senha2:
        print("As senhas não coincidem. Tente novamente.")
        senha2 = input("Insira a senha novamente: ")

    # Parâmetros base
    parametros = {
        'cpf_bind': cpf,
        'nome_bind': name,
        'uf_bind': uf,
        'cidade_bind': cidade,
        'bairro_bind': bairro,
        'rua_bind': rua,
        'numero_bind': nro,
        'telefone1_bind': telefone1,
        'telefone2_bind': telefone2,
        'data_nasc_bind': dtNasc,
        'senha_bind': senha,
    }
    cursor = connection.cursor()
    person_id_out = cursor.var(int)
    parametros['person_id_out'] = person_id_out

    sql = """
        BEGIN
            INSERT INTO PESSOA
                (CPF, NOME, UF, CIDADE, BAIRRO, RUA, NUMERO, TELEFONE1, TELEFONE2, DATA_NASC, SENHA)
            VALUES 
                (:cpf_bind, :nome_bind, :uf_bind, :cidade_bind, :bairro_bind, :rua_bind, :numero_bind, 
                 :telefone1_bind, :telefone2_bind, TO_DATE(:data_nasc_bind, 'DD/MM/YYYY'), :senha_bind)
            RETURNING ID INTO :person_id_out;

    """

    if coren:
        sql += """
            INSERT INTO ENFERMEIRO (ID, COREN)
            VALUES (:person_id_out, :coren_bind);
        """
        parametros["coren_bind"] = coren

    if crm:
        sql += """
            INSERT INTO MEDICO (ID, CRM)
            VALUES (:person_id_out, :crm_bind);
        """
        parametros["crm_bind"] = crm

    sql += "END;"

    try:
        cursor.execute(sql, parametros)
        connection.commit()

        print("Cadastro realizado com sucesso! Logando...")
        cursor.close()
        sc.Esperar(1)
        sc.Logar()

    except oracledb.Error as error:
        connection.rollback()
        print("Erro:", error)

        opt = input("Deseja tentar novamente? [s/n]: ").lower()
        if opt == "s":
            sc.Cadastrar()
        else:
            sc.Sair()


def Logar():

    sc.Header(1)
    
    cpf = input("CPF: ").strip()
    senha = input("Senha: ").strip()

    try:
        cursor = connection.cursor()

        sql_query = """
            SELECT SENHA 
            FROM PESSOA 
            WHERE CPF = :cpf_bind
        """
        
        cursor.execute(sql_query, {'cpf_bind': cpf})
        resultado = cursor.fetchone()

        cursor.close() 

        if not resultado:
            print("CPF não encontrado. Tente novamente...")
            sc.Esperar(1.5)
            return sc.Iniciar()

        senha_bd = resultado[0]

        # Comparar
        if senha == senha_bd:
            print("Credenciais aceitas!")
            sc.Esperar(0.5)
            return sc.Menu()

        else:
            print("Senha incorreta. Tente novamente...")
            sc.Esperar(1.5)
            return sc.Iniciar()

    except oracledb.Error as error:
        print("Erro no login, tente novamente...")
        sc.Esperar(1.5)
        return sc.Iniciar()
