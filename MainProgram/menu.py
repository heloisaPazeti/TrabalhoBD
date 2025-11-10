import commonFunctions as cf 

def EscreveMenu():
    cf.Header(3)

    print("[1] Minhas Pesquisas")
    print("[2] Buscar")
    print("[3] Amostras / Exames")
    print("[4] Deslogar")
    print("[5] Sair")

    opt = input("\n Selecione uma opção: ")

    if(opt == "1"):
        print("1")
    elif(opt == "1"):
        print("1")
    elif(opt == "1"):
        print("1")
    elif(opt == "1"):
        print("1")
    elif(opt == "1"):
        print("1")
    else: 
        print("Comando inexistente...")
        time.sleep(1.5)
        EscreverMenu()
