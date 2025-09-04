from flask import Blueprint, render_template
import os
print("Looking for templates in:", os.path.abspath("quiz/templates"))


quiz_bp=Blueprint('quiz',__name__,template_folder='templates')

@quiz_bp.route('/')
def home():
    return render_template('home.html')