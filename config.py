class Config:
    pass

class DevelopmentConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:admin@localhost/apicf'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

class TestConfig(Config):
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:admin@localhost/apicf_test'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
config = {
    'test': TestConfig,
    'development': DevelopmentConfig
}