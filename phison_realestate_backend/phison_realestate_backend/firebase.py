import json

import environ
from firebase_admin import auth, credentials, initialize_app

env = environ.Env()

service_account = json.loads(env.str("FIREBASE_SERVICE_ACCOUNT_KEY"))

app = initialize_app(credential=credentials.Certificate(service_account))


def verify_token(token):
    decoded_token = auth.verify_id_token(token)
    return decoded_token
