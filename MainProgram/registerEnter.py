import commonFunctions.py as cf
import testCredentials as tc

def Cadastrar():
    
    print("-------------------------------")
    print("|          Cadastro           |")
    print("-------------------------------")

    cpf = input("CPF: ")
    name = input("Nome: ")
    uf = input("UF: ")
    cidade = input("Cidade: ")
    bairro = input("Bairro: ")
    rua = input("Rua: ")
    nro = input("Numero: ")
    telefone1 = input("Telefone Principal: ")
    telefone2 = input("Telefone Secundario (opcional): ")
    dtNasc = input("Data de Nascimento (dd/mm/yyyy): ")
    coren = input("COREN (opcional): ")
    crm = input("CRM (opcional): ")

    senha = input("Senha: ")
    senha2 = input("Insira a senha novamente: ")

    while (senha != senha2):
        print("Parece que algo não deu certo...")
        senha2 = input("Insira a senha novamente: ")

    # FAZER PARADA NO BANCO E VER SE DEU CERTO

    #if(deu certo):
        # print("Cadastro realizado - logando...")
        # Logar()
    #else:
        # opt = input("Parece que algo deu errado... Tentar novamente? [s/n]: ")
        # if (opt == "s"): Cadastrar()
        # else: cf.Sair()

def Logar():
