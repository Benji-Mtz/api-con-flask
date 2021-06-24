# importamos la funcion desde app/
from app import create_app
# importamos la config de
from config import config

enviroment = config['development']

app = create_app(enviroment)

if __name__ == "__main__":
    app.run()