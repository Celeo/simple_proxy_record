from flask import Flask, request, Response


app = Flask(__name__)


@app.route('/<path:path>')
def index(path):
    print('Path:', path)
    print('Headers:\n', '\n'.join([f'\t{k}: {v}' for k, v in request.headers]))
    resp = Response('Index page, with path = ' + path)
    resp.headers["Special"] = "Matt"
    return resp


if __name__ == '__main__':
    app.run(port=5000, debug=True)
