from Utilities.Reusable import Reusable

import json

import g4f

from math import ceil

import urllib.request
import json

from Middlewares.logger import logger


class Person():
    def __init__(self):
        pass

    def verifica_spam_truecaller(self, numero):
        # URL da API do Truecaller para verificação de spam
        url = f'https://search5.truecaller.com/v2/search?q={numero}&countryCode=55&type=4&placement=SEARCHRESULTS,HISTORY,DETAILS&encoding=json'
        
        # Adicione sua chave de API do Truecaller aqui
        headers = {
            'Accept': 'application/json',
            'Authorization': 'Bearer a1i05--nV5gAkVaFAxu4oW5h-a5jRNKbnjePiPN54pTQLJDm9jr1WNCIp7J8xCRF'
        }
        
        try:
            # Cria uma requisição GET usando urllib
            req = urllib.request.Request(url, headers=headers)
            
            # Abre a conexão e obtém a resposta
            with urllib.request.urlopen(req) as response:
                data = response.read()
                data = json.loads(data)
                return data
        
        except urllib.error.HTTPError as e:
            print(f"Erro ao consultar Truecaller API: {e.code} - {e.reason}")
            return None
        except urllib.error.URLError as e:
            print(f"Erro de conexão: {e.reason}")
            return None
        except Exception as e:
            print(f"Erro inesperado: {e}")
            return None

    def check_number(self, number):
        try:
            response = self.verifica_spam_truecaller(number)
            logger.info({'conteudo_number': response})
            score = 0
            desc = "Nenhuma descrição, número parece legitimo."
            if "score" in response["data"][0].keys(): score = 100-ceil(float(response["data"][0]["score"]*100))
            if "name" in response["data"][0].keys(): desc = response["data"][0]["name"]
        except Exception as err:
            logger.info(err)
            score = 100
            desc = "Tivemos um problema ao verificar, tente novamente mais tarde!"
        return {
            "number_score": score,
            "description": desc
        }

    def check_sms(self, number, sms):
        try:
            response = None
            timeout = 0
            while response == None and timeout < 5:
                res = Reusable().useAI(g4f.models.gpt_35_long, \
                    [ \
                        {"role": "user", "content": f"sms: {sms}"}, \
                        {"role": "user", "content": "Sua reposta deve conter APENAS E UNICAMENTE um JSON"}, \
                        {"role": "user", "content": "Este sms pode ser um golpe? retorne a resposta em formato json contendo: chance (de 0 a 100) e motivo"}\
                    ])
                if "chance" in res.keys() and "motivo" in res.keys(): response = res
                timeout += 1

            if timeout == 5:
                response = {
                    "chance": 100,
                    "motivo": "Erro ao tentar acessar nossa AI"
                }

        except Exception as err:
            print(err)
            response = {
                "chance": 100,
                "motivo": "Erro ao tentar acessar nossa AI"
            }

        return {
            "sms_score": response['chance'],
            "sms_score_reason": response['motivo']
        }
