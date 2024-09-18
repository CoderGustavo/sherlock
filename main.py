from fastapi import FastAPI, APIRouter, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.base import BaseHTTPMiddleware
from middlewares.call_middlewares import CallMiddlewares
from classes.Password import Password
from classes.Message import Message
from classes.Url import Url
from classes.App import App
from pydantic import BaseModel

app = FastAPI(
    docs_url="/api/documentation",
    redoc_url="/api/documentation/remastered",
    openapi_url="/api/documentation/openapi.json",
    title="API Documentation for SHERLOCK"
)

router = APIRouter(responses={404: {"description": "Not found"}})

origins = ["http://localhost", "http://localhost:8000", "http://localhost:3000", "*"]

# Adicionando middlewares
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_middleware(BaseHTTPMiddleware, dispatch=CallMiddlewares)

# Model requests
class PasswordCheckRequest(BaseModel):
    password: str

class AppCheckRequest(BaseModel):
    app: str

class SmsCheckRequest(BaseModel):
    sms: str

class UrlCheckRequest(BaseModel):
    url: str

# Validate functions
def validate_password(password: str):
    return Password().check_password(password)

def validate_app(app: str):
    return App().check_app(app)

def validate_sms(sms: str):
    return Message().check_sms(sms)

def validate_url(url: str):
    return Url().check_phishing(url)

# routes
@router.post("/check_password", tags=["password"], summary="Checar se uma senha é forte")
async def check_password(request: PasswordCheckRequest):
    try:
        return validate_password(request.password)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/check_app", tags=["app"], summary="Checar vericidade do app")
async def check_app(request: AppCheckRequest):
    try:
        return validate_app(request.app)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/check_sms", tags=["sms"], summary="Checar se um número e SMS podem ser golpe")
async def check_sms(request: SmsCheckRequest):
    try:
        return validate_sms(request.sms)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/check_url", tags=["url"], summary="Checar se uma URL pode ser golpe")
async def check_url(request: UrlCheckRequest):
    try:
        return validate_url(request.url)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

# Incluindo rotas no app
app.include_router(router)
