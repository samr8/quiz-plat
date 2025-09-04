from flask import Flask
from quiz.routes import quiz_bp
from quiz import models;

def create_app():
    app=Flask(__name__)
    app.config['SECRET_KEY']='supersecretkey'
    app.config['DATABASE']='instance/quiz.db'

    #register blueprints
    app.register_blueprint(quiz_bp)

    app.teardown_appcontext(models.close_db)

    #init command
    @app.cli.command("init-db")
    def init_db_command():
        models.init_db()
        print("Database initilized")

    return app

if __name__=='__main__':
    app=create_app()
    app.run(debug=True)