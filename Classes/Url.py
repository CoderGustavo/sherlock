import requests

from Utilities.ML_utils import Utils

class Url():
    def __init__(self) -> None:
        self.classifier = None
        pass

    def set_classifier(self, classifier):
        self.classifier = classifier

    def check_phishing(self, url):
        errors = []
        r = None
        try:
            url = url if url.startswith('http') else ('http://' + url)
            r = requests.get(url)
            r.raise_for_status()
        except BaseException as error:
            errors.append(
                {
                    "error": error
                }
            )

        if len(errors) > 0:
            return {
                "empresa": "Desconhecida",
                "valida": False,
                "motivo": "Inválido, pois encontramos algum erro ao tentar acessar este site."
            }
        try:
            numerical_values = Utils().get_url(url)
            print(numerical_values)
            response = Utils().model_predict(self.classifier, url)
            print(response)
        except Exception as err:
            print(err)
            return {
                "empresa": "Desconhecida",
                "valida": False,
                "motivo": "Erro ao tentar acessar nossa AI"
            }

        return response