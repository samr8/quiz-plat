from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from quiz.models import get_db

quiz_bp = Blueprint('quiz', __name__, template_folder='templates')

# Home
@quiz_bp.route('/')
def home():
    db = get_db()
    quizzes = db.execute('SELECT id, title, description FROM Quizzes').fetchall()
    return render_template('home.html', quizzes=quizzes, user=session.get("user"))

# Register
@quiz_bp.route('/register', methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        db = get_db()
        try:
            db.execute("INSERT INTO Users (username, password) VALUES (?, ?)", (username, password))
            db.commit()
            flash("Registration successful! Please login.")
            return redirect(url_for("quiz.login"))
        except:
            flash("Username already exists!")
            return redirect(url_for("quiz.register"))

    return render_template("register.html")

@quiz_bp.route('/login', methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        db = get_db()
        user = db.execute(
            "SELECT * FROM Users WHERE username = ? AND password = ?",
            (username, password)
        ).fetchone()

        if user:
            session["user"] = {"id": user["id"], "username": user["username"]}
            flash("Login successful!")
            return redirect(url_for("quiz.home"))
        else:
            flash("Invalid username or password")
            return redirect(url_for("quiz.login"))

    return render_template("login.html")

    return render_template("login.html")

# Logout
@quiz_bp.route('/logout')
def logout():
    session.pop("user", None)
    flash("You have been logged out.")
    return redirect(url_for("quiz.home"))

# Quiz detail (restricted to logged-in users)
@quiz_bp.route('/quiz/<int:quiz_id>')
def quiz_detail(quiz_id):
    if "user" not in session:
        flash("Please log in to attempt quizzes.")
        return redirect(url_for("quiz.login"))

    db = get_db()
    quiz = db.execute("SELECT * FROM Quizzes WHERE id = ?", (quiz_id,)).fetchone()
    if quiz is None:
        return "Quiz not found", 404

    questions = db.execute("SELECT * FROM Questions WHERE quiz_id = ?", (quiz_id,)).fetchall()
    quiz_data = []
    for q in questions:
        options = db.execute("SELECT * FROM Options WHERE question_id = ?", (q["id"],)).fetchall()
        quiz_data.append({"id": q["id"], "text": q["text"], "options": options})

    return render_template("quiz_detail.html", quiz=quiz, questions=quiz_data)

# Submit answers (store results)
@quiz_bp.route('/submit/<int:quiz_id>', methods=["POST"])
def submit_quiz(quiz_id):
    if "user" not in session:
        flash("Please log in to submit quizzes.")
        return redirect(url_for("quiz.login"))

    db = get_db()
    questions = db.execute("SELECT * FROM Questions WHERE quiz_id = ?", (quiz_id,)).fetchall()

    score = 0
    total = len(questions)

    for q in questions:
        selected_option = request.form.get(f"q{q['id']}")
        if selected_option:
            correct_option = db.execute(
                "SELECT id FROM Options WHERE question_id = ? AND is_correct = 1",
                (q["id"],)
            ).fetchone()
            if correct_option and str(correct_option["id"]) == selected_option:
                score += 1

    # Save result in DB
    db.execute(
        "INSERT INTO Results (user_id, quiz_id, score) VALUES (?, ?, ?)",
        (session["user"]["id"], quiz_id, score)
    )
    db.commit()

    return render_template("result.html", score=score, total=total, quiz_id=quiz_id)
