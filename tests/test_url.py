from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_check_url_shorter():
    response = client.post("/check_url", json={"url": "http://tinyurl.com/blbw83"})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") >= 70

def test_check_url_valid():
    response = client.post("/check_url", json={"url": "http://google.com.br"})
    assert response.status_code == 200
    data = response.json()
    assert "score" in data
    assert "reason" in data
    assert data.get("score") <= 20
