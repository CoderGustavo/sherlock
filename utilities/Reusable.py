import concurrent.futures
from fastapi.responses import JSONResponse
from starlette.exceptions import HTTPException
import os
import base64
from random import randint
import json
from utilities.Logger import logger
import google.generativeai as genai

class Reusable:
    """
    Reusable class containing utility methods:
    - throw_error
    - generate_random_number
    - save_image
    - use_ai
    """
    def throw_error(self, field_name: str, error: dict, raise_exception: bool = True):
        """
        Throws or returns an error response.

        Args:
            field_name (str): Name of the field causing the error.
            error (dict): Error dictionary with 'status_code' and 'msg'.
            raise_exception (bool): Whether to raise an HTTP exception or return JSON response.

        Returns:
            JSONResponse or None
        """
        error_message = error.get('msg').replace('<<field>>', f"'{field_name}'")
        if raise_exception:
            raise HTTPException(status_code=error.get('status_code'), detail=error_message)
        return JSONResponse(content=error_message, status_code=error.get('status_code'))

    def generate_random_number(self) -> int:
        """Generates a random 4-digit number."""
        return randint(999, 9999)

    def save_image(self, field_name: str, base_path: str, path_image: str, base64_image: str):
        """
        Decodes and saves an image from a Base64 string.

        Args:
            field_name (str): Name of the field containing the image.
            base_path (str): Directory where the image will be saved.
            path_image (str): Path to the image file.
            base64_image (str): Base64 encoded image data.

        Raises:
            HTTPException: If there's an error saving the image.
        """
        os.makedirs(base_path, exist_ok=True)
        try:
            with open(path_image, "wb") as file:
                decoded_image = base64.b64decode(base64_image, validate=True)
                file.write(decoded_image)
        except Exception as e:
            logger.error(f"Error saving image: {e}")
            if os.path.exists(path_image):
                os.remove(path_image)
            self.throw_error(field_name, {"status_code": 400, "msg": "Error saving the provided image."})

    def use_ai(self, model: str, message: str, timeout_seconds: int = 10) -> dict:
        """
        Generates content using AI with a timeout.

        Args:
            model (str): Model name to use.
            message (str): Input message for the AI model.
            timeout_seconds (int): Maximum time to wait for a response.

        Returns:
            dict: Parsed response from the AI model.

        Raises:
            HTTPException: If the operation times out or fails.
        """
        def generate_content():
            genai.configure(api_key=os.getenv("API_KEY"))
            ai_model = genai.GenerativeModel("gemini-1.5-flash")
            response = ai_model.generate_content(message)
            return json.loads(response.text.replace("```json", "").replace("```", ""))

        try:
            # Using ThreadPoolExecutor to enforce timeout
            with concurrent.futures.ThreadPoolExecutor() as executor:
                future = executor.submit(generate_content)
                return future.result(timeout=timeout_seconds)
        except concurrent.futures.TimeoutError:
            logger.error("AI operation timed out.")
            self.throw_error("AI Model", {"status_code": 408, "msg": "AI request timed out."})
        except Exception as e:
            logger.error(f"AI operation failed: {e}")
            self.throw_error("AI Model", {"status_code": 500, "msg": "Error processing AI request."})
