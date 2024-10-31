import time
import json
from fastapi import Request
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.concurrency import iterate_in_threadpool
from utilities.Logger import logger


class LoggingMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        start_time = time.time()

        # Tentativa de leitura do corpo da requisição de forma segura
        request_body_str = await self._get_request_body(request)

        # Verificação segura do client IP
        client_ip = request.client.host if request.client else "Unknown"

        log_dict = {
            "client_ip": client_ip,
            "url": request.url.path,
            "method": request.method,
            "request_headers": dict(request.headers),
            "request": request_body_str,
        }

        try:
            # Chama o próximo middleware ou endpoint
            response = await call_next(request)

            # Copia o corpo da resposta para reutilização
            response_body_str = await self._get_response_body(response)

            process_time = time.time() - start_time
            response.headers["X-Process-Time"] = str(process_time)

            # Atualiza o dicionário de logs com as informações da resposta
            log_dict["response_headers"] = dict(response.headers)
            log_dict["response"] = response_body_str

        except Exception as e:
            logger.error(f"Erro ao processar a resposta: {str(e)}")
            raise e

        # Loga todas as informações da requisição e resposta
        self._log_request_response(log_dict)

        return response

    async def _get_request_body(self, request: Request) -> str:
        try:
            request_body = await request.body()
            return request_body.decode() if request_body else None
        except Exception as e:
            logger.error(f"Erro ao ler o corpo da requisição: {str(e)}")
            return None

    async def _get_response_body(self, response) -> str:
        try:
            response_body = [chunk async for chunk in response.body_iterator]
            response.body_iterator = iterate_in_threadpool(iter(response_body))
            # Decodifica o corpo da resposta se for texto
            return response_body[0].decode() if response_body and isinstance(response_body[0], bytes) else str(response_body)
        except Exception as e:
            logger.error(f"Erro ao ler o corpo da resposta: {str(e)}")
            return None

    def _log_request_response(self, log_dict):
        try:
            logger.info(json.dumps(log_dict, ensure_ascii=False, indent=2))
        except Exception as e:
            logger.error(f"Erro ao logar a requisição/resposta: {str(e)}")
