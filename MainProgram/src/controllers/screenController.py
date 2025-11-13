from MainProgram.src.screens import start
from MainProgram.src.screens import loginAndRegister as lr 
from MainProgram.src.screens import menu
from MainProgram.src.screens import menuOptions as mo

from MainProgram.src.functions import researchFunctions as rf
from MainProgram.src.functions import commonFunctions as cf
import time
import sys

def Iniciar():
    start.Iniciar()

def Cadastrar():
    lr.Cadastrar()

def Logar():
    lr.Logar()

def Menu():
    menu.Menu()

def MinhasPesquisas():
    mo.MinhasPesquisas()

def Buscar():
    mo.Buscar()

def AdicionarPesquisa():
    Header(6)
    pesquisa = rf.EscreverPesquisa()
    pesquisa.Adicionar()

def ListarPesquisas(lista):
    return rf.ListarPesquisas(lista)

def LimparTela():
    cf.LimparTela()

def Esperar(tempo):
    time.sleep(tempo)

def Header(index):
    cf.Header(index)

def Sair():
    print("Saindo...")
    sys.exit()



        

