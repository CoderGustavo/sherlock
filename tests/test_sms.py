from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_check_sms_golpe_1():
    response = client.post("/check_sms", json={"sms": "Parabéns! Você ganhou um prêmio. Clique aqui para receber."})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") >= 70

def test_check_sms_golpe_2():
    response = client.post("/check_sms", json={"sms": "Para resgatar o prêmio, insira seu CPF"})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") >= 70

def test_check_sms_sem_golpe_1():
    response = client.post("/check_sms", json={"sms": "Oi mãe. Passo ai jantar mais tarde."})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") <= 20

def test_check_sms_sem_golpe_2():
    response = client.post("/check_sms", json={"sms": "Bom dia! Como você está?"})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") <=20

def test_check_sms_golpe_ingles_1():
    response = client.post("/check_sms", json={"sms": "Congratulations! You have won a prize. Click here to claim it."})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") >= 70

def test_check_sms_sem_golpe_ingles_1():
    response = client.post("/check_sms", json={"sms": "Hi mon. I'll come over for dinner later."})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") <= 20

def test_check_sms_no_message():
    response = client.post("/check_sms", json={"sms": ""})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") >= 20
