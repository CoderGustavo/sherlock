from Utilities.Validators import Validators

class Password():
    def __init__(self):
        pass

    def check_password(self, password):
        res = Validators().password(password)
        if not res["res"]:
            return {
                "level": res['error']['password_strength'],
                "description": res['error']['msg']
            }
        return {
            "level": 10,
            "description": "Senha forte!"
        }
