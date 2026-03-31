"""
Then: the secret is "PENDING_DELETION" and will be unavailable to Lambda during the recovery
window
"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SECRET


@then(
    'the "secrets manager" "secret" will be "PENDING_DELETION" and will be unavailable to Lambda during the recovery window'
)  # noqa: E501
def secret_is_pending_deletion_then(lws_session):
    resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
    actual_deleted = resp.get("DeletedDate")
    assert (
        actual_deleted is not None
    ), f"Expected secret '{TEST_SECRET}' to have a DeletedDate (pending deletion) but got None"
