from flask import Flask, request, session, redirect, url_for, render_template, flash
from functools import wraps
import psycopg2
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = 'your_secret_key'
app.config.from_pyfile('config.py')


def get_db_connection():
    conn = psycopg2.connect(**app.config['DATABASE_CONFIG'])
    return conn

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            flash("Please log in to access this page.", "error")
            return redirect(url_for("login"))
        return f(*args, **kwargs)
    return decorated_function

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        #retrieves role in registration, then adds this to the database, user can enter their role
        role_name = request.form['role']
        dname = request.form['department_id']

        hashed_password = generate_password_hash(password)

        conn = get_db_connection()
        cursor = conn.cursor()

        postgreSQL_select_Query = "SELECT id FROM roles WHERE role_name='" + role_name + "'"
        cursor.execute(postgreSQL_select_Query)
        returned = cursor.fetchone()
        role = 0
        if returned:
            role = returned[0]

        postgreSQL_select_Query = "SELECT dnumber FROM department WHERE dname='" + dname + "'"
        cursor.execute(postgreSQL_select_Query)
        returned = cursor.fetchone()
        department_id = 0
        if returned:
            department_id = returned[0]

        try:
            cursor.execute("INSERT INTO users (username, password, role, department_id) VALUES (%s, %s, %s, %s)",
                           (username, hashed_password, role, department_id))
            conn.commit()
            flash('Registration successful! Please log in.')
            return redirect(url_for('login'))
        except Exception as e:
            flash(f"Registration error: {e}")
            conn.rollback()
        finally:
            cursor.close()
            conn.close()

    #get request
    else:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute(f"""CREATE VIEW role_view
                        AS SELECT role_name 
                        FROM roles;""")
        cursor.execute((f"SELECT * FROM role_view;"))
        roleview = cursor.fetchall()  # Retrieve the row for the current user
        
        cursor.execute(f"""CREATE VIEW department_view
                        AS SELECT dname 
                        FROM department;""")
        cursor.execute((f"SELECT * FROM department_view;"))
        departmentview = cursor.fetchall()  # Retrieve the row for the current user
        
        cursor.close()
        conn.close()
        return render_template('register.html', roleview=roleview, departmentview=departmentview)

    return render_template('register.html')


@app.route('/user')
def show_user():
    # Check if the user is logged in
    if 'user_id' not in session:
        flash('You need to log in to view this page.')
        return redirect(url_for('login'))

    # Fetch only the logged-in user's data
    user_id = session['user_id']
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "SELECT id, username, role FROM users WHERE id = %s", (user_id,))
    user = cursor.fetchone()  # Retrieve the row for the current user
    cursor.close()
    conn.close()

    # Pass the user data to the template
    return render_template('user.html', user=user)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            "SELECT id, password FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()
        cursor.close()
        conn.close()

        if user and check_password_hash(user[1], password):
            session['user_id'] = user[0]
            session['username'] = username

            conn = get_db_connection()
            cursor = conn.cursor()

            postgreSQL_select_Query = "SELECT role, department_id FROM users WHERE id=" + str(user[0])
            cursor.execute(postgreSQL_select_Query)
            returned = cursor.fetchone()

            session['role'] = returned[0]
            if returned[0] == 1 or returned[0] == 2:
                session['department'] = returned[1]
            flash('Login successful!')
            cursor.close()
            conn.close()
            return redirect(url_for('index'))
        else:
            flash('Invalid username or password.')

    return render_template('login.html')


@app.route('/users/add', methods=['GET', 'POST'])
def add_user():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        #retrieves role in registration, then adds this to the database, user can enter their role
        role = request.form['role']
        department_id = request.form['dnum']

        hashed_password = generate_password_hash(password)

        conn = get_db_connection()
        cursor = conn.cursor()

        try:
            cursor.execute("INSERT INTO users (username, password, role, department_id) VALUES (%s, %s, %s, %s)",
                           (username, hashed_password, role, department_id))
            conn.commit()
            flash('Registration successful! Please log in.')
            return redirect(url_for('view_users'))
        except Exception as e:
            flash(f"Registration error: {e}")
            conn.rollback()
        finally:
            cursor.close()
            conn.close()

    return render_template('add_user.html')

@app.route('/update/<id>', methods=['GET', 'POST'])
def update_user(id):
    conn = get_db_connection()
    cursor = conn.cursor()
    if request.method == 'POST':
        new_username = request.form['username']
        new_role = request.form['role']
        new_dep_id = request.form['department_id']
        cursor.execute(
            "UPDATE users SET username = %s, role = %s, department_id = %s WHERE id = %s", (new_username, new_role, new_dep_id, id))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('view_users'))

    cursor.execute(
        "SELECT SSN, Fname, Lname, Salary FROM Employee WHERE SSN = %s", (id,))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    return render_template('update_user.html', user=user)

@app.route('/users/delete/<int:id>', methods=('POST',))
def delete_user(id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM users WHERE id = %s", (id,))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('view_users'))


@app.route('/')
@login_required
def index():
    username = session.get('username')
    role = session.get('role')
    #if the user is a Normal
    if role == 1:
        return render_template('dashboard_normal.html', username=username)
    #if the user is a Department Admin
    elif role == 2:
        return render_template('dashboard_dpt_admin.html', username=username)
    #if the user is a Super Admin
    else:
        return render_template('dashboard.html', username=username)

@app.route('/logout')
def logout():
    session.clear()  # Clear all session data to log out
    flash('You have been logged out.')
    return redirect(url_for('login'))

@app.route('/roles')
def view_roles():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, role_name FROM roles ORDER BY id")
    roles = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('roles.html', roles=roles)

@app.route('/update/<id>', methods=['GET', 'POST'])
def update_role_name(id):
    conn = get_db_connection()
    cursor = conn.cursor()
    if request.method == 'POST':
        new_role_name = request.form['role_name']
        cursor.execute(
            "UPDATE roles SET role_name = %s WHERE id = %s", (new_role_name, id))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('view_roles'))

    cursor.execute(
        "SELECT id, role_name FROM roles WHERE id = %s", (id,))
    role = cursor.fetchone()
    cursor.close()
    conn.close()
    return render_template('update_role_name.html', role=role)

@app.route('/users')
def view_users():
    print("sneed")
    role = session.get('role')
    print("ROLE: ", role)
    if role == 3:
        print(role)
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id, Username, password, role, department_id FROM Users")
        users = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('users.html', users=users)
    else:
        return render_template('login.html')

#R: Need to create views
@app.route('/employees')
def view_employees():

    conn = get_db_connection()
    cursor = conn.cursor()

    role = session.get('role')

    #if the user is normal
    if role == 1:
        department = session.get('department')

        cursor.execute(f"""CREATE VIEW employee_department{str(department)} 
                        AS SELECT ssn, Fname, Lname, Salary, Dno 
                        FROM employee WHERE dno={str(department)};""")
                        
        cursor.execute((f"SELECT * FROM employee_department{str(department)};"))

        employees = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('employees_normal.html', employees=employees)

    #if the user is a department manager
    elif role == 2:
        department = session.get('department')
        cursor.execute(("SELECT SSN, Fname, Lname, Salary, dno FROM Employee WHERE dno="+ str(department)))
        employees = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('employees.html', employees=employees)
    
    #The user is a super admin
    else:
        cursor.execute("SELECT SSN, Fname, Lname, Salary, dno FROM Employee")
        employees = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('employees.html', employees=employees)

@app.route('/update/<ssn>', methods=['GET', 'POST'])
def update_salary(ssn):
    conn = get_db_connection()
    cursor = conn.cursor()
    if request.method == 'POST':
        new_salary = request.form['salary']
        cursor.execute(
            "UPDATE Employee SET Salary = %s WHERE SSN = %s", (new_salary, ssn))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('view_employees'))

    cursor.execute(
        "SELECT SSN, Fname, Lname, Salary FROM Employee WHERE SSN = %s", (ssn,))
    employee = cursor.fetchone()
    cursor.close()
    conn.close()
    return render_template('update_salary.html', employee=employee)

@app.route('/departments_super_admin')
def view_departments():
    conn = get_db_connection()
    cursor = conn.cursor()

    role = session.get('role')
    if role == 1:
        department = session.get('department')

        cursor.execute(f"""CREATE VIEW department_department{str(department)} 
                        AS SELECT dname, dnumber, mgr_ssn
                        FROM department WHERE dnumber={str(department)};""")
                        
        cursor.execute((f"SELECT * FROM department_department{str(department)};"))
        departments = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('departments_normal.html', departments=departments)


    elif role == 2:

        department = session.get('department')
        cursor.execute("SELECT Dnumber, Dname, Mgr_ssn FROM Department WHERE Dnumber ="+ str(department))
        departments = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('departments_super_admin.html', departments=departments)

    else:
        cursor.execute("SELECT Dnumber, Dname, Mgr_ssn FROM Department")
        departments = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('departments_super_admin.html', departments=departments)

@app.route('/departments_super_admin/add', methods=('GET', 'POST'))
def add_department():
    if request.method == 'POST':
        dname = request.form['dname']
        dnumber = request.form['dnumber']
        mgr_ssn = request.form['mgr_ssn']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO Department (Dname, Dnumber, Mgr_ssn) VALUES (%s, %s, %s)",
            (dname, dnumber, mgr_ssn)
        )
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('view_departments'))

    return render_template('add_department.html')


# Route to update a department
@app.route('/departments_super_admin/update/<int:dnumber>', methods=('GET', 'POST'))
def update_department(dnumber):
    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        dname = request.form['dname']
        mgr_ssn = request.form['mgr_ssn']

        cursor.execute("UPDATE Department SET Dname = %s, Mgr_ssn = %s WHERE Dnumber = %s",
                       (dname, mgr_ssn, dnumber))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('view_departments'))

    cursor.execute(
        "SELECT Dnumber, Dname, Mgr_ssn FROM Department WHERE Dnumber = %s", (dnumber,))
    department = cursor.fetchone()
    cursor.close()
    conn.close()
    return render_template('update_department.html', department=department)

# Route to delete a department


@app.route('/departments_super_admin/delete/<int:dnumber>', methods=('POST',))
def delete_department(dnumber):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Department WHERE Dnumber = %s", (dnumber,))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('view_departments'))

@app.route('/projects')
def view_projects():
    conn = get_db_connection()
    cursor = conn.cursor()

    role = session.get('role')

    if role == 1:

        department = session.get('department')

        cursor.execute(f"""CREATE VIEW project_department{str(department)} 
                        AS SELECT pnumber, pname, plocation, dnum 
                        FROM project WHERE dnum={str(department)};""")
                        
        cursor.execute((f"SELECT * FROM project_department{str(department)};"))

        projects = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('projects_normal.html', projects=projects)

    elif role == 2:

        cursor.execute("SELECT Pnumber, Pname, Plocation, Dnum FROM Project WHERE dnum="+str(session.get('department')))
        projects = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('projects.html', projects=projects)

    else:

        cursor.execute("SELECT Pnumber, Pname, Plocation, Dnum FROM Project")
        projects = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('projects.html', projects=projects)

@app.route('/projects/add', methods=('GET', 'POST'))
def add_project():
    if request.method == 'POST':
        pname = request.form['pname']
        pnumber = request.form['pnumber']
        plocation = request.form['plocation']
        dnum = request.form['dnum']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO Project (Pname, Pnumber, Plocation, Dnum) VALUES (%s, %s, %s, %s)", (
                pname, pnumber, plocation, dnum)
        )
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('view_projects'))

    return render_template('add_project.html')

# Route to update a project
@app.route('/projects/update/<int:pnumber>', methods=('GET', 'POST'))
def update_project(pnumber):
    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        pname = request.form['pname']
        plocation = request.form['plocation']
        dnum = request.form['dnum']

        cursor.execute("UPDATE Project SET Pname = %s, Plocation = %s, Dnum = %s WHERE Pnumber = %s",
                       (pname, plocation, dnum, pnumber))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('view_projects'))

    cursor.execute(
        "SELECT Pnumber, Pname, Plocation, Dnum FROM Project WHERE Pnumber = %s", (pnumber,))
    project = cursor.fetchone()
    cursor.close()
    conn.close()
    return render_template('update_project.html', project=project)

# Route to delete a project


@app.route('/projects/delete/<int:pnumber>', methods=('POST',))
def delete_project(pnumber):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Project WHERE Pnumber = %s", (pnumber,))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('view_projects'))

@app.route('/joined_data', methods=('GET', 'POST'))
def view_joined_data():
    conn = get_db_connection()
    cursor = conn.cursor()
    role = session.get('role')

    #also ', methods=('GET', 'POST')' above
    #---------------------------------------------------
    if request.method == "POST":
        if role == 1:
            
            department = str(session.get('department'))

            cursor_string_query = f"""CREATE VIEW joined_department{str(department)} 
                            AS (SELECT e.Fname, e.Lname, e.Salary, d.Dname, p.Pname, p.Plocation
                                    FROM Employee e
                                    JOIN Department d ON e.Dno = d.Dnumber
                                    JOIN Project p ON d.Dnumber = p.Dnum
                                    WHERE e.Dno = {department} AND d.Dnumber = {department} AND p.Dnum = {department}
                                    """

            form_ssn = str(request.form['ssn'])
            form_proj = str(request.form['project_id'])

            if form_proj != "":
                cursor_string_query += f"AND p.pnumber = {form_proj}"
            if form_ssn != "":
                cursor_string_query += f"AND e.ssn = '{form_ssn}'"


            cursor_string_query += """ORDER BY e.Lname, e.Fname);"""

            cursor.execute(cursor_string_query)
                            
            cursor.execute((f"SELECT * FROM joined_department{str(department)};"))

            joined_data = cursor.fetchall()
            cursor.close()
            conn.close()

            return render_template('joined_data.html', joined_data=joined_data)

        if role == 2:

            department = str(session.get('department'))

            cursor_string_query = f"""
            SELECT e.Fname, e.Lname, e.Salary, d.Dname, p.Pname, p.Plocation
            FROM Employee e
            JOIN Department d ON e.Dno = d.Dnumber
            JOIN Project p ON d.Dnumber = p.Dnum
            WHERE (e.Dno = {department} OR d.Dnumber = {department} OR p.Dnum = {department})
        """

            form_ssn = str(request.form['ssn'])
            form_proj = str(request.form['project_id'])

            if form_proj != "":
                cursor_string_query += f"AND p.pnumber = {form_proj}"
            if form_ssn != "":
                cursor_string_query += f"AND e.ssn = '{form_ssn}'"

            cursor_string_query += """ORDER BY e.Lname, e.Fname;"""

            cursor.execute(cursor_string_query)

            joined_data = cursor.fetchall()
            cursor.close()
            conn.close()

            return render_template('joined_data.html', joined_data=joined_data)

        
        if role == 3:

            department = str(session.get('department'))

            form_dep = str(request.form['department_number'])
            form_ssn = str(request.form['ssn'])
            form_proj = str(request.form['project_id'])
            print("-------------------")
            print(form_proj)
            print("-------------------")

            cursor_string_query = f"""SELECT e.Fname, e.Lname, e.Salary, d.Dname, p.Pname, p.Plocation
                                    FROM Employee e
                                    JOIN Department d ON e.Dno = d.Dnumber
                                    JOIN Project p ON d.Dnumber = p.Dnum
                                    """
            if form_proj != "":
                cursor_string_query += f"AND p.pnumber = {form_proj}"
            if form_ssn != "":
                cursor_string_query += f"AND e.ssn = '{form_ssn}'"
            if form_dep != "":
                cursor_string_query += f"AND d.dnumber = {form_dep}"

            cursor_string_query += ";"
            cursor.execute(cursor_string_query)

            joined_data = cursor.fetchall()
            cursor.close()
            conn.close()

            return render_template('joined_data.html', joined_data=joined_data)

    #-----------------------------------------------
    
    #Q: is this returning correctly?

    #if it is a post request
    #if the user is normal
    if role == 1:
        department = str(session.get('department'))

        cursor.execute(f"""CREATE VIEW joined_department{str(department)} 
                        AS (SELECT e.Fname, e.Lname, e.Salary, d.Dname, p.Pname, p.Plocation
                                FROM Employee e
                                JOIN Department d ON e.Dno = d.Dnumber
                                JOIN Project p ON d.Dnumber = p.Dnum
                                WHERE e.Dno = {department} AND d.Dnumber = {department} AND p.Dnum = {department}
                                ORDER BY e.Lname, e.Fname);""")
                        
        cursor.execute((f"SELECT * FROM joined_department{str(department)};"))

        joined_data = cursor.fetchall()
        cursor.close()
        conn.close()

        return render_template('joined_data.html', joined_data=joined_data)
    
    elif role == 2:
        department = str(session.get('department'))

        cursor.execute(f"""
            SELECT e.Fname, e.Lname, e.Salary, d.Dname, p.Pname, p.Plocation
            FROM Employee e
            JOIN Department d ON e.Dno = d.Dnumber
            JOIN Project p ON d.Dnumber = p.Dnum
            WHERE e.Dno = {department} OR d.Dnumber = {department} OR p.Dnum = {department}
            ORDER BY e.Lname, e.Fname;
        """)

        joined_data = cursor.fetchall()
        cursor.close()
        conn.close()

        return render_template('joined_data.html', joined_data=joined_data)

    else:
        
        # Example SQL join query to fetch data from Employee, Department, and Project tables
        cursor.execute("""
            SELECT e.Fname, e.Lname, e.Salary, d.Dname, p.Pname, p.Plocation
            FROM Employee e
            JOIN Department d ON e.Dno = d.Dnumber
            JOIN Project p ON d.Dnumber = p.Dnum
            ORDER BY e.Lname, e.Fname;
        """)

        joined_data = cursor.fetchall()
        cursor.close()
        conn.close()

        return render_template('joined_data.html', joined_data=joined_data)
    




@app.route('/test_login_required')
@login_required
def test_login_middleware():
    return "If you see this message it means you are logged in!!!!!!!!!!!!!!"


if __name__ == "__main__":
    app.run(debug=True)
