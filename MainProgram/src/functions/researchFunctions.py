from MainProgram.src.controllers import screenController as sc

from MainProgram.objects import research as res

def ListarPesquisas(listaPesquisas):
    
    print("[0] Voltar")
    print("-------------------------------")

    for i in range(len(listaPesquisas)):
        print(f"[{i+1}] - {listaPesquisas[i].titulo}")
    
    print("-------------------------------")
    opt = input("\n Selecione para ver detalhes: ")
    index = int(opt)-1
    
    if(opt == "0"):
        sc.Menu()
        return True
    elif(index in range(len(listaPesquisas))):
        result = listaPesquisas[index].MostrarPesquisa()
        if(result): 
            return True
    else:
        print("Parece que isso não é uma opção... Tente novamente...")
        sc.Esperar(1.5)
        sc.Menu()
        return False

def EscreverPesquisa():
    
    print("Adicione as seguintes informações:\n")
    titulo = input("Titulo: ")
    area = input("Área: ")
    dtCriacao = input("Data de Criação (dd/mm/yyyy): ")
    universidade = input("Universidade: ")
    agFomento = input("Agência de Fomento: ")
    pesqResponsa = input("Pesquisador Responsável: ")
    pesqs = input("Pesquisadores (separar por , ): ")
    desc = input("Descrição: ")

    pesquisa = res.Pesquisa(titulo, area, dtCriacao, universidade, agFomento, pesqResponsa, pesqs, desc)
    
    return pesquisa
