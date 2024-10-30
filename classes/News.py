from utilities.Reusable import Reusable

from middlewares.logger import logger


class News():
    def __init__(self):
        pass

    def check_news(self, news):
        try:
            response = None
            timeout = 0
            while response == None and timeout < 5:
                res = None
                try:
                    res = Reusable().useAI("gemini", f"""

Noticia: {news}

Essa notícia pode ser fake news, ser verídica ou parcialmente verídica?
Quero que pesquise sobre essa noticia. Caso não encontre nenhuma informação, não invente nada, não peça mais informações, não faça sugestões ou recomendações, não dê justificativas.
Caso a noticia informada não for realmente uma noticia (sendo um numero, texto aleatorio, uma mensagem), coloque que é uma noticia falsa e na descrição informe que nada foi encontrado e que não parece uma noticia.

Você deve retornar apenas um JSON com as keys: fake, description
sendo fake um valor true ou false, sendo "true" para se a noticia é falsa e "false" se a noticia for verdadeira
sendo description uma mensagem explicando brevemente a noticia e a fonte da noticia, deve possuir até 200 caracteres

Pegue as ultimas informações do dia de hoje e informe no description a data da fonte

                    """)
                    print(res)
                except Exception as err:
                    logger.info(err)

                try:
                    if ("fake" in res.keys() and
                            "description" in res.keys()):
                        response = res
                except:
                    print("DEU PAU aqui")

                timeout += 1

            if response: return response
            if timeout == 5:
                return {
                    "fake": False,
                    "description": "Erro ao tentar acessar nossa AI",
                }

        except Exception as err:
            logger.info(err)
            return {
                "fake": False,
                "description": "Erro ao tentar acessar nossa AI",
            }

        return response
