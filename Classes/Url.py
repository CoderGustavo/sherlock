from Utilities.Validators import Validators
from starlette.exceptions import HTTPException

import json

import g4f

import requests

class Url():
    def __init__(self):
        pass

    def check_phishing(self, url):
        errors = []
        r = None
        try:
            r = requests.get(url)
            r.raise_for_status()
        except BaseException as error:
            errors.append(
                {
                    "error": error
                }
            )

        if len(errors) > 0:
            return {
                "empresa": "Desconhecida",
                "valida": False,
                "motivo": f"Inválido, pois encontramos algum erro ao tentar acessar este site."
            }

        response = g4f.ChatCompletion.create(
            model=g4f.models.gpt_35_long,
            provider=g4f.Provider.FreeGpt,
            messages=[ \
                {"role": "user", "content": url}, \
                {"role": "user", "content": "Considere sites com protocolo http como INVÁLIDOS"}, \
                {"role": "user", "content": "Sua reposta deve conter apenas um json"}, \
                {"role": "user", "content": "Esta url é valida? retorne a resposta em formato json contendo: empresa, se é valida e motivo (explique EM POUCAS PALAVRAS o porque é inválido ou válido)"}]
        )

        response = json.loads(response)

        return response