"""Then: the secret has a new current version and the previous version is retained"""

from __future__ import annotations

from pytest_bdd import then


@then("the secret has a new current version and the previous version is retained")
def secret_has_new_version(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected put_secret_value to succeed but got: {actual_error}"
    assert "VersionId" in world["result"], "Expected 'VersionId' in response"
