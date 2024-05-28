from Utilities.Reusable import Reusable

import json

import g4f

import shlex
import subprocess
from math import ceil

from Middlewares.logger import logger

import requests

class Person():
    def __init__(self):
        pass

    def check_number(self, number):
        print(number)
        try:
            cmd = f'''
                curl https://search5.truecaller.com/v2/search?q={number}&countryCode=55&type=4&placement=SEARCHRESULTS,HISTORY,DETAILS&encoding=json
                -H "Accept: application/json"
                -H "Authorization: Bearer a1i0U--n5MXr9VPkdIzKqC-fMJkEmGWrbnvL-sXc7tj-kG4OLXOKlEGvM7HY-c8r"
            '''
            args = shlex.split(cmd)
            process = subprocess.Popen(args, shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = process.communicate()
            # stdout = requests.get(
            #     'https://search5.truecaller.com/v2/search?q={number}&countryCode=55&type=4&placement=SEARCHRESULTS,HISTORY,DETAILS&encoding=json',
            #     headers={
            #             'Accept': 'application/json',
            #             'Authorization': 'Bearer a1i0U--n5MXr9VPkdIzKqC-fMJkEmGWrbnvL-sXc7tj-kG4OLXOKlEGvM7HY-c8r'
            #         }
            #     )
            logger.info({'conteudo_number': stdout})
            logger.info({'conteudo_number_error': stderr})
            response = json.loads(stdout)
            logger.info({'conteudo_number_json': response})
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
            number_check = self.check_number(number)
            number_score = number_check["number_score"]
            number_score_reason = number_check["description"]
        except Exception as err:
            logger.info(err)
            number_score = 0
            number_score_reason = "Tivemos algum erro ao tentar validar o número inserido."

        try:
            response = None
            timeout = 0
            while response == None and timeout < 5:
                res = Reusable().useAI(g4f.models.gpt_35_long, \
                    [ \
                        {"role": "user", "content": f"sms: {sms}"}, \
                        {"role": "user", "content": "Sua reposta deve conter apenas um json"}, \
                        {"role": "user", "content": "Este sms com esse número pode ser um golpe? retorne a resposta em formato json contendo: nivel de chance de 0 a 100 e motivo"}\
                    ])
                if "nivel_de_chance" in res.keys() and "motivo" in res.keys(): response = res
                timeout += 1

            if timeout == 5:
                response = {
                    "nivel_de_chance": 100,
                    "motivo": "Erro ao tentar acessar nossa AI"
                }

        except Exception as err:
            print(err)
            response = {
                "nivel_de_chance": 100,
                "motivo": "Erro ao tentar acessar nossa AI"
            }

        return {
            "number_score": number_score,
            "number_score_reason": number_score_reason,
            "sms_score": response['nivel_de_chance'],
            "sms_score_reason": response['motivo']
        }
