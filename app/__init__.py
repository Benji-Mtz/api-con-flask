from flask import Flask

# desde el modulo de models
from .models import db
from .models.task import Task

from .views import api_v1

app = Flask(__name__)

def create_app(environment):
    app.config.from_object(environment)
    
    app.register_blueprint(api_v1)
    # Despues de definir el modelo (tabla) configuramos la DB
    with app.app_context():
        db.init_app(app)
        db.create_all()
        
    return app