from werkzeug.security import generate_password_hash
from app import db, User, app

def create_user(username, password):
    hashed_password = generate_password_hash(password, method='pbkdf2:sha256', salt_length=16)
    user = User(username=username, password=hashed_password)

    with app.app_context():
        db.create_all()
        existing_user = User.query.filter_by(username=username).first()
        if existing_user:
            print(f"El usuario '{username}' ya existe.")
        else:
            db.session.add(user)
            db.session.commit()
            print(f"Usuario '{username}' creado correctamente.")

if __name__ == '__main__':
    create_user('admin', '123456')
