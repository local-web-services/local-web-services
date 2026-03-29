"""Then: the secret is "ACTIVE" again and the recovery window is closed"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SECRET


@then('the secret is "ACTIVE" again and the recovery window is closed')
def secret_is_active_again(lws_session):
    resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
    assert (
        "DeletedDate" not in resp
    ), f"Expected secret to be ACTIVE (no DeletedDate) but got: {resp.get('DeletedDate')}"
