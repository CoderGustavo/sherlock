from Utilities.Reusable import Reusable

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
                "motivo": "Inválido, pois encontramos algum erro ao tentar acessar este site."
            }
        
        try:
            response = None
            timeout = 0
            while response == None or timeout < 5:
                res = Reusable().useAI(g4f.models.gpt_35_long, \
                    [ \
                        {"role": "user", "content": url.strip()}, \
                        {"role": "user", "content": "Considere sites com protocolo http como INVÁLIDOS"}, \
                        {"role": "user", "content": "Sua reposta deve conter apenas um json e não tente estilizar"}, \
                        {"role": "user", "content": "Esta url é valida? retorne a resposta em formato json contendo ( empresa, valida e motivo ) (explique EM POUCAS PALAVRAS o porque é inválido ou válido)"}\
                    ])
                if "empresa" in res.keys() and "valida" in res.keys() and "motivo" in res.keys(): response = res
                timeout += 1

            if timeout == 5:
                return {
                "empresa": "Desconhecida",
                "valida": False,
                "motivo": "Erro ao tentar acessar nossa AI"
            }

        except Exception as err:
            print(err)
            return {
                "empresa": "Desconhecida",
                "valida": False,
                "motivo": "Erro ao tentar acessar nossa AI"
            }

        return response