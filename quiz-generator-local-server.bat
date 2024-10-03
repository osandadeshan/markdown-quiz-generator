@echo off
python quiz-generator.py
cd docs
start http://localhost:8000/
python -m http.server 8000
