from Utilities.Reusable import Reusable

import g4f

from Middlewares.logger import logger

from typing import Dict

class Url():
    def __init__(self):
        pass

    def check_phishing(self, url):
        try:
            response = None
            timeout = 0
            while response == None and timeout < 5:
                print(url.strip())
                res = None
                try:
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
                except Exception as err:
                    logger.info(err)
                    
                if isinstance(res, Dict) and "empresa" in res.keys() and "valida" in res.keys() and "motivo" in res.keys(): response = res
                timeout += 1

            if response: return response
            if timeout == 5:
                return {
                "empresa": "Desconhecida",
                "valida": False,
                "motivo": "Erro ao tentar acessar nossa AI"
            }

        except Exception as err:
            logger.info(err)
            return {
                "empresa": "Desconhecida",
                "valida": False,
                "motivo": "Erro ao tentar acessar nossa AI"
            }

        return response
