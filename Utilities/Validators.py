import re
from itertools import cycle

class Validators():
    # Validators class
    # methods of this class are:
    # ['__init__', 'full', 'gt3', 'phone', 'email', 'password', 'img', 'uuid', 'cpf', 'cnpj', 'datetime', 'unique', 'username']

    def __init__(self):
        return None

    def full(self, value, values):
        msgError = "Valor inserido no campo <<field>> deve estar cheio"
        return {'res': True} if value else {'res': False, 'error': {'msg': msgError, 'status_code': 400}}

    def gt3(self, value, values):
        msgError = "Valor inserido no campo <<field>> deve possuir mais de 3 caracteres"
        return {'res': True} if len(value) > 3 else {'res': False, 'error': {'msg': msgError, 'status_code': 400}}

    def phone(self, value, values):
        country = "".join(re.findall(r'\+\d+\s', value))
        numbers = re.findall(r'\d+', value)
        if country:
            numbers = "".join(numbers).replace(country, "")
        else:
            msgError = "Valor inserido no campo <<field>> deve ser em um formato válido. Ex: +55 35 12345-6789"
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}
        
        if len(numbers) < 11:
            msgError = "Valor inserido no campo <<field>> deve possuir mais de 11 caracteres"
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}
        return {'res': True}

    def email(self, value, values):
        regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b'
        valid = re.fullmatch(regex, value)
        if not valid:
            msgError = "Valor inserido no campo <<field>> deve ser um formato válido. Ex: teste@gmail.com"
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}
        return {'res': True}

    def password(self, password):

        length_error = len(password) < 8
        digit_error = re.search(r"\d", password) is None
        uppercase_error = re.search(r"[A-Z]", password) is None
        lowercase_error = re.search(r"[a-z]", password) is None
        symbol_error = re.search(r"[ @!#$?%&'()*+,-./[\\\]^_`{|}~"+r'"]', password) is None

        password_strength = 0
        if length_error: return {'res': False, 'error': {'msg': "Esta senha possui menos de 8 caracteres", 'status_code': 400, 'password_strength': password_strength}}
        password_strength += 2
        if digit_error: return {'res': False, 'error': {'msg': "Esta senha não possui um digito numérico", 'status_code': 400, 'password_strength': password_strength}}
        password_strength += 2
        if uppercase_error: return {'res': False, 'error': {'msg': "Esta senha não possui uma letra maiúscula", 'status_code': 400, 'password_strength': password_strength}}
        password_strength += 2
        if lowercase_error: return {'res': False, 'error': {'msg': "Esta senha não possui uma letra minuscula", 'status_code': 400, 'password_strength': password_strength}}
        password_strength += 2
        if symbol_error: return {'res': False, 'error': {'msg': "Esta senha não possui um carácter especial", 'status_code': 400, 'password_strength': password_strength}}

        return {'res': True}

    def img(self, value, values):
        try:
            image = str(re.sub(r"data:image\/.*;base64,", "", value)).strip()
        except:
            msgError = "Valor inserido no campo <<field>> deve ser uma imagem válida.)"
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}
        return {'res': True}
    def uuid(self, value, values):
        if len(value) != 24:
            msgError = "Valor inserido no campo <<field>> deve ser um uuid válido."
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}
        return {'res': True}
    def cpf(self, value, values):
        cpf = value

        if values.get("company_type") != "Física":
            return {'res': True}

        #Retira apenas os dígitos do CPF, ignorando os caracteres especiais
        numeros = [int(digito) for digito in cpf if digito.isdigit()]

        quant_digitos = False
        validacao1 = False
        validacao2 = False

        if len(numeros) == 11:
            quant_digitos = True
        
            soma_produtos = sum(a*b for a, b in zip (numeros[0:9], range (10, 1, -1)))
            digito_esperado = (soma_produtos * 10 % 11) % 10
            if numeros[9] == digito_esperado:
                validacao1 = True

            soma_produtos1 = sum(a*b for a, b in zip(numeros [0:10], range (11, 1, -1)))
            digito_esperado1 = (soma_produtos1 *10 % 11) % 10
            if numeros[10] == digito_esperado1:
                validacao2 = True
            if quant_digitos == False and validacao1 == False and validacao2 == False:
                msgError = "Valor inserido no campo <<field>> deve ser um cpf válido."
                return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}
        else:
            msgError = "Valor inserido no campo <<field>> deve ser um cpf válido."
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}
        return {'res': True}
    def cnpj(self, value, values):
        cnpj = value
        cnpj = "".join([digito for digito in cnpj if digito.isdigit()])
        if values.get("company_type") == "Física":
            return {'res': True}
        if len(cnpj) != 14:
            msgError = "Valor inserido no campo <<field>> deve ser um cnpj válido."
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}

        if cnpj in (c * 14 for c in "1234567890"):
            msgError = "Valor inserido no campo <<field>> deve ser um cnpj válido."
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}

        cnpj_r = cnpj[::-1]
        for i in range(2, 0, -1):
            cnpj_enum = zip(cycle(range(2, 10)), cnpj_r[i:])
            dv = sum(map(lambda x: int(x[1]) * x[0], cnpj_enum)) * 10 % 11
            if cnpj_r[i - 1:i] != str(dv % 10):
                msgError = "Valor inserido no campo <<field>> deve ser um cnpj válido."
                return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}

        return {'res': True}
    def datetime(self, value, values):
        return {'res': True}

    def username(self, value, values):
        res = bool(re.match("^[A-Za-z0-9_-]*$", value))
        if not res: 
            msgError = "Valor inserido no campo <<field>> deve ser um username válido. Deve conter apenas Letras, Números, _ e - "
            return {'res': False, 'error': {'msg': msgError, 'status_code': 400}}
        return {'res': True}
