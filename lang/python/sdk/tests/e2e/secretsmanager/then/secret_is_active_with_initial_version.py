"""Then: the "secrets manager" "secret" will be "ACTIVE" with an initial version"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SECRET


@then('the "secrets manager" "secret" will be "ACTIVE" with an initial version')
def secret_is_active_with_initial_version(lws_session):
    resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
    assert (
        "DeletedDate" not in resp
    ), f"Expected secret to be ACTIVE but got DeletedDate: {resp.get('DeletedDate')}"
    assert (
        resp.get("Name") == TEST_SECRET
    ), f"Expected secret name '{TEST_SECRET}' but got: {resp.get('Name')}"
