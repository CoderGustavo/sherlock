from Middlewares.logger import logger
from fastapi import Request
from starlette.concurrency import iterate_in_threadpool
import time

async def CallMiddlewares(request: Request, call_next):
    start_time = time.time()
    request_body = await request.body()
    log_dict = {
        'client_ip': request.client.host,
        'url': request.url.path,
        'method': request.method,
        'request_headers': request.headers,
        'request': request_body
    }

    response = await call_next(request)

    response_body = [chunk async for chunk in response.body_iterator]
    response.body_iterator = iterate_in_threadpool(iter(response_body))

    process_time = time.time() - start_time

    response.headers["X-Process-Time"] = str(process_time)

    log_dict["response_headers"] = response.headers
    log_dict["response"] = response_body[0].decode()

    logger.info(log_dict)

    return response