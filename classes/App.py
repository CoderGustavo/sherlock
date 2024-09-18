from utilities.Reusable import Reusable

from middlewares.logger import logger

class App():
    def __init__(self):
        pass

    def check_app(self, name):
        try:
            response = None
            timeout = 0
            while response == None and timeout < 5:
                res = None
                try:
                    res = Reusable().useAI("gemini", f"""
Você deve se comportar como um profissional da segurança

Abaixo está o nome do app:
"{name}"

Este app acima pode ser um app de phishing? de golpe? ou algo que possar ser perigoso? tem informações sobre a vericidade do app?

Você deve retornar apenas um JSON com as keys: score, reason, description, play_store, app_store
sendo valid um valor de 0 a 100 com a chance de ser golpe
sendo reason uma mensagem explicando o motivo de ser ou não golpe de no máximo 100 caracteres
sendo description uma mensagem explicando qual a categoria do app e sua funcionalidade
sendo play_store um valor 0 ou 1, se tem para download na play store
sendo app_store um valor de 0 ou 1, se tem para download na app store

Caso o app passado não for um app valido, coloque que é golpe e informe que não parece ser um app valido (retorne todos as keys informadas anteriormente)
                    """)
                    print(res)
                except Exception as err:
                    logger.info(err)

                try:
                    if ("score" in res.keys() and
                            "reason" in res.keys() and
                            "description" in res.keys() and
                            "play_store" in res.keys() and
                            "app_store" in res.keys()):
                        response = res
                except:
                    print("DEU PAU")

                timeout += 1

            if response: return response
            if timeout == 5:
                return {
                    "score": False,
                    "reason": "Erro ao tentar acessar nossa AI",
                    "description": "Erro",
                    "play_store": 0,
                    "app_store": 0
                }

        except Exception as err:
            logger.info(err)
            return {
                "score": False,
                "reason": "Erro ao tentar acessar nossa AI",
                "description": "Erro",
                "play_store": 0,
                "app_store": 0
            }

        return response
