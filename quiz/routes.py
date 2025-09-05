from flask import Blueprint, render_template, request
from quiz.models import get_db
quiz_bp=Blueprint('quiz',__name__,template_folder='templates')

@quiz_bp.route('/')
def home():
    db=get_db()
    quizzes=db.execute('SELECT id,title, description FROM Quizzes').fetchall()
    print("DEBUG: quizzes fetched =", quizzes)   # 👈 add this
    return render_template('home.html',quizzes=quizzes)

@quiz_bp.route('/quiz/<int:quiz_id>')
def quiz_detail(quiz_id):
    db=get_db()
    quiz=db.execute("select * from Quizzes where id = ?",(quiz_id,)).fetchone()
    if quiz is None:
        return "Quiz not found",404


    questions = db.execute("SELECT * FROM Questions WHERE quiz_id = ?", (quiz_id,)).fetchall()
    quiz_data = []
    for q in questions:
        options = db.execute("SELECT * FROM Options WHERE question_id = ?", (q["id"],)).fetchall()
        quiz_data.append({"id": q["id"], "text": q["text"], "options": options})

    return render_template("quiz_detail.html", quiz=quiz, questions=quiz_data)

# Submit answers
@quiz_bp.route('/submit/<int:quiz_id>', methods=["POST"])
def submit_quiz(quiz_id):
    db = get_db()

    # Fetch all questions for this quiz
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

    return render_template("result.html", score=score, total=total)

