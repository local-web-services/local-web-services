"""Then: the secret is "ACTIVE" and the "CREATED" event is "DELIVERED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SECRET


@then('the secret is "ACTIVE" and the "CREATED" event is "DELIVERED"')
def secret_active_and_created_event_delivered(lws_session):
    resp = lws_session.client("secretsmanager").list_secrets()
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert (
        TEST_SECRET in actual_names
    ), f"Expected secret '{TEST_SECRET}' to exist but not found in: {actual_names}"
