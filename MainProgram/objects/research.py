from MainProgram.src.controllers import screenController as sc
from MainProgram.src.functions import researchFunctions as rf

class Pesquisa:
    def __init__(self, titulo, area, dtCriacao, universidade, agFomento, pesqResponsa, pesqs, descricao):

        self.id = 0
        self.titulo = titulo
        self.area = area
        self.dtCriacao = dtCriacao
        self.universidade = universidade
        self.agFomento = agFomento
        self.pesqResponsa = pesqResponsa
        self.pesqs = pesqs
        self.descricao = descricao

    def MostrarPesquisa(self):

        sc.LimparTela()

        print(f"Titulo: {self.titulo}")
        print(f"Area: {self.area}")
        print(f"Data de Criacao: {self.dtCriacao}")
        print(f"Universidade: {self.universidade}")
        print(f"Agência de Fomento: {self.agFomento}")
        print(f"Pesquisador Responsavel: {self.pesqResponsa}")
        print(f"Pesquisador(es): {self.pesqs}")
        print(f"Descricao: {self.descricao}")
        
        print("--------------------------------------------------")
        print("[0] Voltar")
        print("[1] Alterar")
        print("[2] Deletar")

        opt = input("Selecione uma opção: ")

        if(opt == "0"):
            sc.Menu()
        elif(opt == "1"):
            self.Alterar()
        elif(opt == "2"):
             self.Deletar()
        else:
            print("Comando inexistente...")
            sc.Esperar(0.5)
            self.MostrarPesquisa()

    def Adicionar(self):

        result = True
        # result = query INSERT INTO
        if(result):
            print("Pesquisa Adicionada!")
        else:
            print("Parece que algo deu errado")

        sc.Esperar(0.5)
        sc.Menu()

    def Alterar(self):
        
        result = True
        novaPesquisa = rf.EscreverPesquisa()
        #novaPesquisa.id = self.id
        #SQL -> Alter Table
        #result = query
        if(result):
            print("Pesquisa Alterada!")
        else:
            print("Parece que algo deu errado.")

        sc.Esperar(0.5)
        sc.Menu()

    def Deletar(self):
        opt = input("Tem certeza que deseja deletar essa pesquisa? [s/n]")
        if(opt == "s"):
            print("Deletando Pesquisa... ")
            sc.Esperar(0.5)
            #result = query DELETE self.id
            result = True
            if(result):
                sc.Menu()
            else:
                print("Parece que tivemos um problema...")
                sc.Esperar(1)
                sc.Menu()
        else:
            self.MostrarPesquisa()
