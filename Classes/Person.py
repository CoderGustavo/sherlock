from Utilities.Validators import Validators
from starlette.exceptions import HTTPException

import json

import g4f

import shlex
import subprocess
from math import ceil

class Person():
    def __init__(self):
        pass

    def check_number(self, number):
        cmd = f'''
curl https://search5-noneu.truecaller.com/v2/search?q={number}&countryCode=55&type=4&placement=SEARCHRESULTS,HISTORY,DETAILS&encoding=json
-H "Accept: application/json"
-H "Authorization: Bearer a1i0d--lWx3p0VJkqMnqWFxi1LOgLzhnyCqYU21CZvAj6NbgxFwTryo1B7BGLk0I"
        '''
        args = shlex.split(cmd)
        process = subprocess.Popen(args, shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()
        response = json.loads(stdout)

        score = 0
        desc = "Nenhuma descrição, número parece legitimo."
        if "score" in response["data"][0].keys(): score = 100-ceil(float(response["data"][0]["score"]*100))
        if "name" in response["data"][0].keys(): desc = response["data"][0]["name"]

        return {
            "number_score": score,
            "description": desc
        }

    def check_sms(self, number, sms):
        number_check = self.check_number(number)
        number_score = number_check["number_score"]
        number_score_reason = number_check["description"]

        response = g4f.ChatCompletion.create(
            model=g4f.models.gpt_35_long,
            provider=g4f.Provider.FreeGpt,
            messages=[ \
                {"role": "user", "content": f"número: {number}"}, \
                {"role": "user", "content": f"sms: {sms}"}, \
                {"role": "user", "content": "Sua reposta deve conter apenas um json"}, \
                {"role": "user", "content": "Este sms pode ser um golpe? retorne a resposta em formato json contendo: nivel de chance de 0 a 100 e motivo"}]
        )
        response = json.loads(response)

        return {
            "number_score": number_score,
            "number_score_reason": number_score_reason,
            "sms_score": response['nivel_de_chance'],
            "sms_score_reason": response['motivo']
        }