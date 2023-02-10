import json

import requests


def get_usd_to_etb_exchange_rate():
    try:
        response = requests.get(
            "https://api.coinbase.com/v2/exchange-rates?currency=USD"
        )

        response_dict = json.loads(response.content)
        return response_dict["data"]["rates"]["ETB"]
    except Exception:
        # Estimated rate in case API doesn't work
        return 53.72716900602903
