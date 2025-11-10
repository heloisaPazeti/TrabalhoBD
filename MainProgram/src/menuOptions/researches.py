from src import commonFunctions as cf

def MinhasPesquisas():
    
    cf.Header(4)


    # Pesquisar na tabela todas as pesquisas que estão relacioandas a Pessoa
    # Eu imagino que vai voltar uns objetos - que tem que criar - numa lista
    # E a ideia seria a printar tudo em order:
        # [1] - Titulo 1
        # [2] - Titulo 2
        # ...
        # [index n] - Titulo n
    # E a pessoa poder escolher uma dessas pra ver detalhes
    # Ai abre uma outra tela com os detalhes da pesquisa
   
    # listaPesquisa = {...}


    print("[0] Voltar")
    # for printando todo mundo da lista
    opt = input("\n Selecione uma opcao: ")


    if(opt == "0"):
        return True
    #else:
        #if(listaPesquisa[opt.toInt()] != Null):
            #result = MostrarPesquisa(listaPesquisa[opt.toInt()])
            #if(result): MinhasPesquisas

def MostrarPesquisa(pesquisa):

    pesquisa.MostrarPesquisa()

    input("\n Pressione qualquer tecla para voltar...")
    return True 
