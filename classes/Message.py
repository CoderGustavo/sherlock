from utilities.Reusable import Reusable

class Message():
    def __init__(self):
        pass

    def check_sms(self, sms: str):
        try:
            response = None
            timeout = 0
            while response == None and timeout < 5:
                res = Reusable().useAI("gemini", f"""
Você deve se comportar como um profissional da segurança

Abaixo está uma mensagem de SMS:
"{sms}"

Essa mensagem acima é uma mensagem de golpe? por levar uma pessoa a passar informações, ser roubada, perder informações, clicar em links

Você deve retornar apenas um JSON com as keys: score e reason
sendo score um valor de 0 a 100 com a change de ser golpe
sendo reason uma mensagem explicando o motivo de ser ou não golpe de no máximo 100 caracteres

Caso a mensagem passada não for uma mensagem valida, coloque que é golpe e informe que não parece ser uma mensagem
                """)

                if "score" in res.keys() and "reason" in res.keys(): response = res
                timeout += 1

            if timeout == 5:
                response = {
                    "score": 100,
                    "reason": "Erro ao tentar acessar nossa AI"
                }

        except Exception as err:
            print("err")
            print(err)
            response = {
                "score": 100,
                "reason": "Erro ao tentar acessar nossa AI"
            }

        return {
            "score": response['score'],
            "reason": response['reason']
        }
