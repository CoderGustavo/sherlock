from fastapi import FastAPI, APIRouter
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.base import BaseHTTPMiddleware
from Middlewares.CallMiddlewares import CallMiddlewares

from Classes.Password import Password
from Classes.Person import Person
from Classes.Url import Url

app = FastAPI(
    docs_url="/api/documentation",
    redoc_url="/api/documentation/remastered",
    openapi_url="/api/documentation/openapi.json",
    title="API Documentation for SHERLOCK"
)
router = APIRouter(
    responses={404: {"description": "Not found"}}
)

origins = [
    "http://localhost",
    "http://localhost:8000",
    "http://localhost:3000",
    "*",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_middleware(BaseHTTPMiddleware, dispatch=CallMiddlewares)


# This method will check the password that will be passed
@app.post("/check_password",
        tags=["password"],
        summary="Utilize para checar se uma senha é forte!",
        description="""
Neste endpoint é esperado o retorno de um json contendo:
- level ( 0 a 10, sendo 0 fraco e 10 forte ) INT
- description ( Qual a motivo do level da senha ) STRING
""")
def check_password(password: str):
    return Password().check_password(password)

# This method will check the telephone number that will be passed
@app.post("/check_number",
        tags=["sms"],
        summary="Utilize para checar se um número pode ser golpe!",
        description="""
Neste endpoint é esperado o retorno de um json contendo:
- number_score ( 0 a 100, sendo 0 não golpe e 100 golpe ) INT
- description ( Qual a motivo do score do número informado ) STRING
""")
def check_number(phone: str):
    return Person().check_number(phone)

# This method will check the telephone number and sms that will be passed
@app.post("/check_sms",
        tags=["sms"],
        summary="Utilize para checar se uma número e um sms podem ser golpe!",
        description="""
Neste endpoint é esperado o retorno de um json contendo:
- number_score ( 0 a 100, sendo 0 não golpe e 100 golpe ) INT
- number_score_reason ( Qual a motivo do score do número informado ) STRING
- sms_score ( 0 a 100, sendo 0 não golpe e 100 golpe ) INT
- sms_score_reason ( Qual a motivo do score do sms informado ) STRING
""")
def check_sms(sms: str, phone: str = 0):
    return Person().check_sms(phone, sms)

# This method will check the telephone number and sms that will be passed
@app.post("/check_url",
        tags=["url"],
        summary="Utilize para checar se uma url pode ser golpe!",
        description="""
Neste endpoint é esperado o retorno de um json contendo:
- empresa ( qual a empresa que possivelmente é dona da url informada ) STRING
- valida ( se é uma url válida ou não ) BOOLEAN
- motivo ( qual o motivo de ser válida ou ser inválida ) STRING
""")
def check_url(url: str):
    return Url().check_phishing(url)
