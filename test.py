# server.py
from flask import Flask, request, jsonify
import g4f

app = Flask(__name__)


def gpt(messages, model="gpt-4-32k-0613"):
    response = g4f.ChatCompletion.create(
        model=model,
        provider=g4f.Provider.GptGo,
        messages=messages,
        n=1,
        stop=["User:"],
        temperature=0.5
    )
    return response


@app.route('/', methods=['POST'])
def chat():
    data = request.get_json()
    user_message = data.get('user_message')

    messages = [{"role": "user", "content": user_message}]
    response = gpt(messages)

    return jsonify({'bot_response': response})


if __name__ == '__main__':
    app.run()
