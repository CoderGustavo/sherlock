from middlewares.logger import logger
from fastapi import Request
from starlette.concurrency import iterate_in_threadpool
import time
import json

async def CallMiddlewares(request: Request, call_next):
    start_time = time.time()

    # Tentativa de leitura do corpo da requisição de forma segura
    try:
        request_body = await request.body()
        request_body_str = request_body.decode() if request_body else None
    except Exception as e:
        logger.error(f"Erro ao ler o corpo da requisição: {str(e)}")
        request_body_str = None

    # Verificação segura do client IP
    client_ip = request.client.host if request.client else "Unknown"

    log_dict = {
        'client_ip': client_ip,
        'url': request.url.path,
        'method': request.method,
        'request_headers': dict(request.headers),
        'request': request_body_str
    }

    try:
        # Chama o próximo middleware ou endpoint
        response = await call_next(request)

        # Copia o corpo da resposta para reutilização
        response_body = [chunk async for chunk in response.body_iterator]
        response.body_iterator = iterate_in_threadpool(iter(response_body))

        process_time = time.time() - start_time
        response.headers["X-Process-Time"] = str(process_time)

        # Decodifica o corpo da resposta se for texto
        response_body_str = response_body[0].decode() if response_body and isinstance(response_body[0], bytes) else str(response_body)

        # Atualiza o dicionário de logs
        log_dict["response_headers"] = dict(response.headers)
        log_dict["response"] = response_body_str

    except Exception as e:
        logger.error(f"Erro ao processar a resposta: {str(e)}")
        raise e

    # Loga todas as informações
    try:
        logger.info(json.dumps(log_dict, ensure_ascii=False, indent=2))
    except Exception as e:
        logger.error(f"Erro ao logar a requisição/resposta: {str(e)}")

    return response
