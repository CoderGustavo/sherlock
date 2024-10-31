from fastapi import Request
import time
import psutil
from starlette.middleware.base import BaseHTTPMiddleware

from utilities.Logger import logger


class ResourceMonitorMiddleware(BaseHTTPMiddleware):
    def _get_cpu_usage(self):
        cpu_usage_per_core = psutil.cpu_percent(interval=None, percpu=True)
        total_cpu_usage = sum(cpu_usage_per_core) / len(cpu_usage_per_core)

        return total_cpu_usage

    async def dispatch(self, request: Request, call_next):
        # Dados iniciais de CPU e RAM antes da requisição
        process = psutil.Process()
        cpu_start = self._get_cpu_usage()
        ram_start = process.memory_info().rss / (1024 * 1024)  # Convertendo para MB

        # Captura o total disponível de CPU e RAM
        total_cpu_available = 100 - cpu_start  # Total de CPU disponível em porcentagem
        total_ram_available = psutil.virtual_memory().available / (1024 * 1024)  # RAM disponível em MB

        # Tempo de início
        start_time = time.time()

        # Executa a rota
        response = await call_next(request)

        # Dados finais de CPU e RAM após a requisição
        cpu_end = self._get_cpu_usage()
        ram_end = process.memory_info().rss / (1024 * 1024)  # Convertendo para MB

        # Calcula o uso de CPU e RAM
        cpu_usage = cpu_end - cpu_start
        ram_usage = ram_end - ram_start

        # Calcula o tempo de processamento
        process_time = time.time() - start_time

        # Loga as informações
        logger.info(f"Tempo de processamento para {request.url.path}: {process_time:.4f} segundos")
        logger.info(f"Uso de CPU: {cpu_usage:.2f}%, Total de CPU disponível: {total_cpu_available:.2f}%")
        logger.info(f"Uso de RAM: {ram_usage:.2f} MB, Total de RAM disponível: {total_ram_available:.2f} MB")

        # Adiciona as informações nos headers da resposta (opcional)
        response.headers["X-Process-Time"] = str(process_time)
        response.headers["X-Total-CPU-Available"] = f"{total_cpu_available:.2f}%"
        response.headers["X-CPU-Usage"] = f"{cpu_usage:.2f}%"
        response.headers["X-Total-RAM-Available"] = f"{total_ram_available:.2f} MB"
        response.headers["X-RAM-Usage"] = f"{ram_usage:.2f} MB"

        return response
