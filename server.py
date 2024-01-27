from flask import Flask, request, jsonify
import g4f

app = Flask(__name__)


@app.route('/', methods=['POST'])
def chat():
    if request.method == 'POST':
        # Retrieve data from the request
        data = request.get_json()
        messages = data.get('messages')
        response = g4f.ChatCompletion.create(
            model="gpt-4-32k-0613",
            provider=g4f.Provider.GeekGpt,
            messages=messages,
            # n=1,
            # stop=["User:"],

        )
        response_messages = response
        return jsonify({"response": response_messages})


if __name__ == '__main__':
    app.run()
