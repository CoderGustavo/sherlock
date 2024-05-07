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
            url = url if url.startswith('http') else ('http://' + url)
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
            while response == None and timeout < 5:
                print(url.strip())
                res = Reusable().useAI(g4f.models.gpt_35_long, \
                    [ \
                        {"role": "user", "content": url.strip()}, \
                        {"role": "user", "content": "Sua reposta deve conter apenas um json e não tente estilizar"}, \
                        {"role": "user", "content": "Formato de retorno: JSON"}, \
                        {"role": "user", "content": "Campos de retorno: empresa, valida e motivo"}, \
                        {"role": "user", "content": "Esta url é valida? Explique EM POUCAS PALAVRAS"}, \
                        {"role": "user", "content": "Campo motivo deve conter toda a descrição, deve ser simples e confia!"}, \
                        {"role": "user", "content": "Na descrição traga se o site parece confiavel e do que se trata e se pode ser prejudicial ao acessar."}\
                    ])
                print(res.keys())
                if "empresa" in res.keys() and "valida" in res.keys() and "motivo" in res.keys(): response = res
                print(res)
                timeout += 1

            if response: return response
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