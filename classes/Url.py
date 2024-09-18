from utilities.Reusable import Reusable

from middlewares.logger import logger

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
                    res = Reusable().useAI("gemini", f"""
Você deve se comportar como um profissional da segurança

Abaixo está uma url:
"{url}"


Este link acima pode ser um link de phishing? de golpe? ou algo que possar ser perigoso? como links encurtados, link de casa de aposta, link de sites replicados

Você deve retornar apenas um JSON com as keys: score e reason
sendo valid um valor de 0 a 100 com a chance de ser golpe
sendo reason uma mensagem explicando o motivo de ser ou não golpe de no maximo 100 caracteres

Caso o link passado não for um link valido, coloque que é golpe e informe que não parece ser um link valido
                    """)
                    print("TESTE")
                    print(res)
                except Exception as err:
                    logger.info(err)

                try:
                    if "score" in res.keys() and "reason" in res.keys(): response = res
                except:
                    print("DEU PAU")

                timeout += 1

            if response: return response
            if timeout == 5:
                return {
                "score": False,
                "reason": "Erro ao tentar acessar nossa AI"
            }

        except Exception as err:
            logger.info(err)
            return {
                "score": False,
                "reason": "Erro ao tentar acessar nossa AI"
            }

        return response
