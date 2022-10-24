from firebase_admin import auth

from phison_realestate_backend.firebase import verify_token


class TestFirebase:
    def test_calls_firebase_verify_id_token(self, mocker):
        mocker.patch("firebase_admin.auth.verify_id_token")
        verify_token("testtoken")
        auth.verify_id_token.assert_called_once_with("testtoken")

    def test_returns_decoded_token(self, mocker):
        mocker.patch(
            "firebase_admin.auth.verify_id_token", return_value={"uid": "testuid"}
        )
        result = verify_token("testtoken")
        assert result == {"uid": "testuid"}
