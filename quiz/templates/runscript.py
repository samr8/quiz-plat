import sqlite3

conn = sqlite3.connect('quiz.db')  # use your database filename
cur = conn.cursor()

cur.execute("ALTER TABLE Results ADD COLUMN taken_at TEXT;")

conn.commit()
conn.close()
