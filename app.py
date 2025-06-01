from flask import Flask, render_template, redirect, url_for, request, flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, login_user, login_required, logout_user, UserMixin, current_user
from werkzeug.security import check_password_hash
from flask import request, jsonify
from datetime import datetime
#from models import db, Tarea
from flask_login import login_required
from datetime import date

app = Flask(__name__)
app.secret_key = 'clave_secreta'  # Cambia esto por una clave segura
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/flask_auth'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Modelo de usuario
class User(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)

# Modelo de tareas
class Tarea(db.Model):
    __tablename__ = 'tareas'

    id = db.Column(db.Integer, primary_key=True)
    titulo = db.Column(db.String(100))
    descripcion = db.Column(db.Text)
    fecha_vencimiento = db.Column(db.Date)
    estado = db.Column(db.String(1))    

# Flask-Login
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username'].strip()
        password = request.form['password'].strip()

        user = User.query.filter_by(username=username).first()
        if user:
            print("Hash en BD:", user.password)
            print("Contraseña ingresada:", password)
            print("Resultado check:", check_password_hash(user.password, password))

        if user and check_password_hash(user.password, password):
            login_user(user)
            flash('Inicio de sesión exitoso', 'success')
            return redirect(url_for('dashboard'))
        else:
            flash('Usuario o contraseña incorrectos', 'danger')
            return redirect(url_for('login'))

    return render_template('login.html')

@app.route('/dashboard')
@login_required
def dashboard():
    #Colocar filtro por estado y ordenamiento por fecha (ASC/DESC)
    tareas = Tarea.query.all() 
    return render_template('dashboard.html', user=current_user, items=tareas)

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Sesión cerrada', 'info')
    return redirect(url_for('login'))


@app.route('/agregar', methods=['POST'])
@login_required
def agregar():
    data = request.get_json()

    try:
        # Convertir string a fecha (formato yyyy-mm-dd)
        fecha = datetime.strptime(data['fecha_vencimiento'], '%Y-%m-%d').date()

        # Validar que la fecha sea mayor que hoy
        if fecha <= date.today():
            return jsonify({'success': False, 'message': 'La fecha de vencimiento no debe estar en el pasado.'})

        nueva_tarea = Tarea(
            titulo=data['titulo'].strip(),
            descripcion=data['descripcion'].strip(),
            fecha_vencimiento=fecha,
            estado=data['estado'].strip()
        )

        db.session.add(nueva_tarea)
        db.session.commit()

        return jsonify({'success': True, 'message': 'Tarea guardada correctamente.'})
    
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'message': f'Error al guardar: {str(e)}'})

@app.route('/actualizar', methods=['POST'])
@login_required
def actualizar():
    data = request.get_json()
    print("Datos recibidos en actualizar:", data)
    try:
        #tarea = Tarea.query.get(data['id'])
        tarea = db.session.get(Tarea, data['id'])
        if not tarea:
            return jsonify({'success': False, 'message': 'Tarea no encontrada.'})

        # Confirmación viene del cliente (puede manejarse con confirm() en JS)
        tarea.titulo = data['titulo'].strip()
        tarea.descripcion = data['descripcion'].strip()
        tarea.fecha_vencimiento = datetime.strptime(data['fecha_vencimiento'], '%Y-%m-%d').date()
        tarea.estado = data['estado'].strip()

        # Validar fecha
        if tarea.fecha_vencimiento <= datetime.today().date():
            return jsonify({'success': False, 'message': 'La fecha de vencimiento no debe estar en el pasado.'})

        db.session.commit()
        return jsonify({'success': True, 'message': 'Tarea actualizada correctamente.'})

    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'message': f'Error al actualizar: {str(e)}'})

@app.route('/eliminar', methods=['POST'])
@login_required
def eliminar():
    data = request.get_json()
    print("Datos recibidos en actualizar:", data)
    try:
        #tarea = Tarea.query.get(data['id'])
        tarea = db.session.get(Tarea, data['id'])
        if not tarea:
            return jsonify({'success': False, 'message': 'Tarea no encontrada.'})

        db.session.delete(tarea)
        db.session.commit()

        return jsonify({'success': True, 'message': 'Tarea eliminada correctamente.'})
    
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'message': f'Error al eliminar: {str(e)}'})


#--------------------------------------------------
#   INICIO DE LA APP
#--------------------------------------------------
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
