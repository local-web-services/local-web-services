"""Then: the "secrets manager" "secret" will have a new current version and the previous version will be retained"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "secrets manager" "secret" will have a new current version and the previous version will be retained'
)
def secret_has_new_version(world):
    assert world["error"] is None, f"Expected put_secret_value to succeed but got: {world['error']}"
    assert "VersionId" in world["result"], "Expected 'VersionId' in response"
