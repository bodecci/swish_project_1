from flask import Flask
import subprocess

app = Flask(__name__)

@app.route("/")
def hello_world():
    # Run Python 3 Hello World
    python3_output = subprocess.check_output(["python3", "-c", "print('Hello World from Python 3')"]).decode().strip()
    
    #extra comment to force pipeline.
    # Run R Hello World
    r_output = subprocess.check_output(["Rscript", "-e", "cat('Hello World from R\\n')"]).decode().strip()

    # Combine all outputs
    return f"""
    <html>
    <head><title>Hello World App</title></head>
    <body>
        <h1>Hello World Application</h1>
        <p>{python3_output}</p>
        <p>{r_output}</p>
    </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
