from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_check_password_2():
    response = client.post("/check_password", json={"password": "senha"})
    assert response.status_code == 200
    data = response.json()
    assert "level" in data
    assert "description" in data
    assert data.get("level") == 2

def test_check_password_4():
    response = client.post("/check_password", json={"password": "minhasenha"})
    assert response.status_code == 200
    data = response.json()
    assert "level" in data
    assert "description" in data
    assert data.get("level") == 4

def test_check_password_6():
    response = client.post("/check_password", json={"password": "minhasenha123"})
    assert response.status_code == 200
    data = response.json()
    assert "level" in data
    assert "description" in data
    assert data.get("level") == 6

def test_check_password_8():
    response = client.post("/check_password", json={"password": "Minhasenha123"})
    assert response.status_code == 200
    data = response.json()
    assert "level" in data
    assert "description" in data
    assert data.get("level") == 8

def test_check_password_10():
    response = client.post("/check_password", json={"password": "Minhasenha123@"})
    assert response.status_code == 200
    data = response.json()
    assert "level" in data
    assert "description" in data
    assert data.get("level") == 10
