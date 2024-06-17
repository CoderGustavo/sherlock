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
                res = None
                try:
                    res = Reusable().useAI(g4f.models.gpt_35_long, \
                        [ \
                            {"role": "user", "content": f"{url.strip()} é uma url valida? Explique, seja acertivo e descritivo, informe do que se trata o link"}, \
                            {"role": "user", "content": f"não utilize o protocolo como criterio de avaliação"}, \
                            {"role": "user", "content": "Campos de retorno: empresa, valida (boolean value) e motivo"}, \
                            {"role": "user", "content": "Sua reposta deve conter APENAS E UNICAMENTE um JSON"}, \
                        ])
                    print("TESTE")
                    print(res)
                except Exception as err:
                    logger.info(err)

                try:
                    if "empresa" in res.keys() and "valida" in res.keys() and "motivo" in res.keys(): response = res
                except:
                    print("DEU PAU")

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
