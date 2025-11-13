from MainProgram.src.controllers import screenController as sc
from MainProgram.objects import research as res

from MainProgram.src.functions import testCredentials as tc

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
    sc.Adicionar()

