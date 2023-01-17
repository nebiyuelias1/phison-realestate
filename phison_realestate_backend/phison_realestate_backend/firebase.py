from firebase_admin import auth, initialize_app

app = initialize_app()


def verify_token(token):
    decoded_token = auth.verify_id_token(token)
    return decoded_token
