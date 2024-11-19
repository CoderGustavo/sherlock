from utilities.Reusable import Reusable

from utilities.Logger import logger

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
                    res = Reusable().use_ai("gemini", f"""
Você deve se comportar como um profissional da segurança

Abaixo está o nome do app:
"{name}"

Avalie se um aplicativo é confiável ou possui características que indicam que pode ser usado para golpes (phishing, fraudes, ou outro comportamento malicioso). Sua análise deve ser focada no aplicativo em si e não em possíveis ações de terceiros. Por exemplo, aplicativos legítimos como redes sociais podem ser usados por pessoas mal-intencionadas para golpes, mas isso não torna o aplicativo inseguro.

Você deve retornar apenas um JSON com as seguintes chaves:

score: um número de 0 a 100 indicando a probabilidade de o app ser um golpe (0 = completamente seguro, 100 = quase certamente golpe).
reason: uma mensagem de no máximo 100 caracteres explicando o motivo para o score atribuído.
description: uma breve descrição do aplicativo, explicando sua categoria e funcionalidade principal.
play_store: um valor binário (0 ou 1) indicando se o app está disponível para download na Google Play Store.
app_store: um valor binário (0 ou 1) indicando se o app está disponível para download na App Store.
Se o aplicativo parecer inválido (exemplo: nome estranho, sem informações claras ou não localizado nas lojas oficiais), informe que há alta chance de ser golpe. Para esses casos, use o seguinte padrão:

score: 100
reason: "Não parece ser um aplicativo válido."
description: "Não há informações suficientes para identificar este aplicativo."
play_store: 0
app_store: 0
O JSON deve estar formatado corretamente e conter todas as chaves acima. Evite adicionar qualquer texto fora do formato JSON.
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
