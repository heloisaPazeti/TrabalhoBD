import commonFunctions as cf
import registerEnter as re

def main() :

    Iniciar()

def Iniciar ():
    
    print("-------------------------------")
    print("|         Bem-Vindo           |")
    print("-------------------------------")
    print("[1] Logar")
    print("[2] Cadastrar")
    print("[3] Sair")

    opt = input()

    if (opt == "1"):
        re.Logar()
    elif (opt == "2"):
        re.Cadastrar()
    elif (opt == "3"):
        cf.Sair()
    else:
        print("Comando não encontrado... Tente novamente.")
        Iniciar()

main()
