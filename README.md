# Markdown Quiz Generator

## Introduction
It is a tool to generate quizzes from Markdown files. This means that you can structure the format of the text, bold, italic, tables, etc.

**Markdown**:
![p1](https://raw.githubusercontent.com/osandadeshan/markdown-quiz-generator/master/app/static/sample-quiz-md-file.PNG)

**Quiz**:
![p2](https://raw.githubusercontent.com/osandadeshan/markdown-quiz-generator/master/app/static/sample-quiz-animation.gif)

---

## Requirements
**install.bat** - Automatically download and install all requirements and dependencies ([Python-3.12.x](https://www.python.org/), [pip](https://pypi.org/project/pip/))

---

## Manual Installation
Once `python` and `pip` are installed, simply run (within the application already downloaded):

```bash
python -m pip install -r requirements.txt
```

---

## Quiz structure (Markdown)
Although it is based on markdown for its style format, at the moment the following types of questions are supported:

1. **Question of a selection**:
```text
1. MaxSoft is a software company.
    - (x) True
    - ( ) False
```
```text
2. The domain of MaxSoft is test automation framework development.
    - (x) True
    - ( ) False 
```
Note that the correct answer is specified with an **x** ( x or X, upper or lower case) and must be in parentheses to specify that it is only one to be selected, for example, for false or true questions.

2. **Multiple selection question**:
```text
3. What are the test automation frameworks developed by MaxSoft?
    - [x] IntelliAPI
    - [x] WebBot
    - [ ] Gauge
    - [ ] Selenium
```
Very similar to the previous one but this type of question allows you to select more than one at a time, they must be in square brackets with an **x** to the correct answers. The result to these types of questions is prorated, that is, you must select only the correct ones so that that question is interpreted as correct.

Note that for questions types 1 and 2, you must leave a space for the wrong answers, eg. () or [], the questions must be multiple selection or a selection, you cannot mix them.

3. **Open question** (Enter text)
```text
4. Who is the Co-Founder of MaxSoft?
    - R:= Osanda
```
It is a question where you must write the correct answer, this is specified in the following line of the question preceded by **R: =** (R or, upper or lower case) then the correct answer (it is validated regardless of whether it is uppercase or lowercase)

---

## Designing the quiz
There are several tools out there on the internet that allow you to preview Markdown files. 
Some online examples:

1. https://dillinger.io/
2. https://markdownlivepreview.com/

---

## Generating quizzes
The application will generate all the **.md** (Markdown) files that are inside the folder `./markdown-quiz-files/**`. Note that this folder already has a default quiz (sample-quiz.md).

You can add as many as Markdown files you want, and each of them will be generated separate quizzes.

To generate quizzes, there are two batch files,
1. `quiz-generator-local.bat`

This is a batch file that simply executes `python quiz-generator.py` and will generate the quizzes including the required libraries (Bootstrap, jQuery) to execute it independently in the browser (usually to verify that everything is fine).

2. `quiz-generator-local-server.bat`

This is a batch file that executes, 

```
python quiz-generator.py
cd docs
start http://localhost:8000/
python -m http.server 8000
```

This is almost same as `quiz-generator-local.bat`. The only difference is, this will spin up a new local server for your quizzes at http://localhost:8000/

3. `quiz-generator-embed.bat`

This is a batch file that simply executes `python quiz-generator.py embed` in this way the quizzes will be generated without including any external library, it is assumed that it will be included in another Web as (Embedded).

The resulting quizzes will have the same name of the markdown file but with their .html extension, they will be created in the `./docs/` folder.

---

## Deploy GitHub Pages

1. Deploy the `/docs/` directory to GitHub pages to serve publicly on the web. After creating a quiz in the `/docs/` directory, add a link to the `/docs/index.html` file.

2. Go to Settings in your GitHub repository. Select **Pages** on the left navigation bar.  Select **Deploy from a Branch**.  Then select the **docs** directory to deploy from.

3. Once you've set up GitHub Pages, you can navigate to **Actions** and follow the progress of the deployment.  If the deployment is successful, you'll see the green dot as show below.

![image](https://github.com/user-attachments/assets/f4290cb3-4560-4174-a6c6-2776ab9faec7)

4. Return to **Settings/Pages** to find the link to the deployed web site.

![image](https://github.com/user-attachments/assets/fac9a6e5-db6e-4807-8fd2-a814280f0ae0)

**Note**: The **index.html** will provide links to available quizzes.

![Deployed Quiz App](https://osandadeshan.github.io/markdown-quiz-generator/)
