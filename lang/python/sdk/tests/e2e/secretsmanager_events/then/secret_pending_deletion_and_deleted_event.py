"""Then: the "secrets manager" "secret" will be "PENDING_DELETION" and the "DELETED" event will be "DELIVERED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SECRET


@then(
    'the "secrets manager" "secret" will be "PENDING_DELETION" and the "DELETED" event will be "DELIVERED"'
)
def secret_pending_deletion_and_deleted_event(lws_session):
    resp = lws_session.client("secretsmanager").list_secrets(IncludePlannedDeletion=True)
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert (
        TEST_SECRET in actual_names
    ), f"Expected secret '{TEST_SECRET}' to still appear (PENDING_DELETION) but not found in: {actual_names}"  # noqa: E501
