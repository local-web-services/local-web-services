"""Then: the "secrets manager" "secret" will be "ACTIVE" again and the recovery window will be closed"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SECRET


@then(
    'the "secrets manager" "secret" will be "ACTIVE" again and the recovery window will be closed'
)
def secret_is_active_again(lws_session):
    resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
    assert (
        "DeletedDate" not in resp
    ), f"Expected secret to be ACTIVE (no DeletedDate) but got: {resp.get('DeletedDate')}"
