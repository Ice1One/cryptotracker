import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["app"] == "Crypto Price Tracker"

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"

def test_prices_returns_list():
    response = client.get("/prices")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_track_invalid_coin():
    response = client.post("/track/invalidcoinxyz123")
    assert response.status_code == 404

def test_untrack_nonexistent_coin():
    response = client.delete("/track/invalidcoinxyz123")
    assert response.status_code == 404
