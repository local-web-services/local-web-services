"""Then: the list of secrets will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the list of secrets will be returned")
def list_of_secrets_returned(world):
    assert world["error"] is None, f"Expected list_secrets to succeed but got: {world['error']}"
    assert "SecretList" in world["result"], "Expected 'SecretList' in response"
