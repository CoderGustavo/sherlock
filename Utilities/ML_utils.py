from urllib.parse import urlparse
import re
from googlesearch import search
import numpy as np

class Utils():
    def __init__(self) -> None:
        pass

    def abnormal_url(self, URL: str) -> int:
        hostname = urlparse(URL).hostname
        hostname = str(hostname)
        match = re.search(hostname, URL)
        if match:
            return 1
        else:
            return 0

    def having_ip_address(self, URL: str) -> int:
        match = re.search(
            '(([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.'
            '([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\/)|'  # IPv4
            '((0x[0-9a-fA-F]{1,2})\\.(0x[0-9a-fA-F]{1,2})\\.(0x[0-9a-fA-F]{1,2})\\.(0x[0-9a-fA-F]{1,2})\\/)' # IPv4 in hexadecimal
            '(?:[a-fA-F0-9]{1,4}:){7}[a-fA-F0-9]{1,4}', URL)  # Ipv6
        if match:
            return 1
        else:
            return 0

    def sum_count_special_characters(self, URL: str) -> int:
        special_chars = ['@','?','-','=','.','#','%','+','$','!','*',',','//']
        num_special_chars = sum(char in special_chars for char in URL)
        return num_special_chars

    def is_http_secured(self, URL: str) -> int:
        htp = urlparse(URL).scheme
        match = str(htp)
        if match == 'https':
            return 1
        else:
            return 0

    def digit_count(self, URL: str) -> int:
        digits = 0
        for i in URL:
            if i.isnumeric():
                digits = digits + 1
        return digits

    def letter_count(self, URL: str) -> int:
        letters = 0
        for i in URL:
            if i.isalpha():
                letters = letters + 1
        return letters

    def is_shortining_service(self, URL):
        match = re.search(
                        'bit\.ly|goo\.gl|shorte\.st|go2l\.ink|x\.co|ow\.ly|t\.co|tinyurl|tr\.im|is\.gd|cli\.gs|'
                        'yfrog\.com|migre\.me|ff\.im|tiny\.cc|url4\.eu|twit\.ac|su\.pr|twurl\.nl|snipurl\.com|'
                        'short\.to|BudURL\.com|ping\.fm|post\.ly|Just\.as|bkite\.com|snipr\.com|fic\.kr|loopt\.us|'
                        'doiop\.com|short\.ie|kl\.am|wp\.me|rubyurl\.com|om\.ly|to\.ly|bit\.do|t\.co|lnkd\.in|'
                        'db\.tt|qr\.ae|adf\.ly|goo\.gl|bitly\.com|cur\.lv|tinyurl\.com|ow\.ly|bit\.ly|ity\.im|'
                        'q\.gs|is\.gd|po\.st|bc\.vc|twitthis\.com|u\.to|j\.mp|buzurl\.com|cutt\.us|u\.bb|yourls\.org|'
                        'x\.co|prettylinkpro\.com|scrnch\.me|filoops\.info|vzturl\.com|qr\.net|1url\.com|tweez\.me|v\.gd|'
                        'tr\.im|link\.zip\.net',
                        URL)
        if match:
            return 1
        else:
            return 0

    def google_index(self, URL):
        site = search(URL, 5)
        return 1 if site else 0

    def get_url(self, url):
        url = url.replace('www.', '')
        url_len = len(url)
        letters_count = self.letter_count(url)
        digits_count  = self.digit_count(url)
        special_chars_count = self.sum_count_special_characters(url)
        shortened = self.is_shortining_service(url)
        abnormal = self.abnormal_url(url)
        secure_https = self.is_http_secured(url)
        have_ip = self.having_ip_address(url)
        index_google = self.google_index(url)

        return {
            'url_len': url_len,
            'letters_count': letters_count,
            'digits_count': digits_count,
            'special_chars_count': special_chars_count,
            'shortened': shortened,
            'abnormal': abnormal,
            'secure_http': secure_https,
            'have_ip': have_ip,
            'GoogleIndex' : index_google
        }

    def model_predict(self, classifier, url):
        class_mapping = {
            0: 'CUIDADO! Link suspeito',
            1: 'Link Confiável'
        
        }
        numerical_values = self.get_url(url)
        prediction_int = classifier.predict(np.array(list(numerical_values.values())).reshape(1, -1))[0]
        prediction_label = class_mapping.get(prediction_int, 'Unknown')
        return {
            'motivo': prediction_label
        }