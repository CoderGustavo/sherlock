from starlette.exceptions import HTTPException
import os
from fastapi.responses import JSONResponse
import base64
from random import randint
import g4f
import json

from Middlewares.logger import logger

class Reusable():
    # Reusable class
    # methods of this class are:
    # ['__init__', 'throwError', 'randomNumber', 'saveImage']

    def __init__(self):
        return None

    def throwError(self, fieldName, error, exception=True):
        errorMessage = error.get('msg').replace('<<field>>', f"'{fieldName}'");
        if exception:
            raise HTTPException(status_code=error.get('status_code'), detail=errorMessage)
        else:
            return JSONResponse(content=errorMessage, status_code=error.get('status_code'))
    def randomNumber(self):
        return randint(999, 9999)
    def saveImage(self, fieldName, basePath, pathImage, base64Image):
        deleteFile = True
        dirCreate = f"{basePath}"
        if not os.path.exists(dirCreate): os.mkdir(dirCreate)
        pathFile = str(f"{pathImage}")
        try:
            with open(pathFile, "wb") as fh:
                decoded = base64.b64decode(base64Image, validate=True)
                fh.write(decoded)
        except Exception as e:
            print(e)
            os.remove(pathFile)
            self.throwError(fieldName, {"status_code": 400, "msg": "Erro ao salvar a foto inserida."})

        return None

    def useAI(self, model, message):
        response = g4f.ChatCompletion.create(
            model= model,
            messages=message
        )
        logger.info(response)
        return json.loads(response.replace("```json", "").replace("```", ""))
