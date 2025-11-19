import psycopg2

# ----------------------------------------------------------
# FUNCAO: Retornar conexão e cursor
# ----------------------------------------------------------
# - Cria conexão
# - Cria cursor
# - Retorna ambos
# ----------------------------------------------------------
def GetConnectionAndCursor():

    conn = psycopg2.connect(
        host="localhost",
        port=5432,
        database="trabalhobd",
        user="grupoquatro",
        password="4444"
    )

    cursor = conn.cursor()

    return conn, cursor
