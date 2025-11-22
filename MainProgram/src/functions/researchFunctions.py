from MainProgram.src.controllers import screenController as sc
from MainProgram.objects import research as res

# -----------------------------------------------------
# FUNCAO: Listar todas as pesquisas para seleciona-las
# -----------------------------------------------------
# - Parâmetros: lista do objeto Pesquisa, id do pesquisador
# - Printa todas as pesquisas na lista, mostrando um indice e seu titulo
# - Permite voltar
# - Permite selecionar uma das pesquisas para mostrar seus detalhes
# -----------------------------------------------------
def ListarPesquisas(listaPesquisas, idPerson):
    
    print("[0] Voltar")
    print("-------------------------------")

    for i in range(len(listaPesquisas)):
        print(f"[{i+1}] - {listaPesquisas[i].titulo}")
    
    print("-------------------------------")
    opt = input("\n Selecione para ver detalhes: ")
    index = int(opt)-1
    
    if(opt == "0"):
        sc.Menu(idPerson)
        return True
    elif(index in range(len(listaPesquisas))):
        result = listaPesquisas[index].MostrarPesquisa()
        if(result): 
            return True
    else:
        print("Parece que isso não é uma opção... Tente novamente...")
        sc.Esperar(1.5)
        sc.Menu(idPerson)
        return False

