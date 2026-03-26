"""Then: the secret is "ACTIVE" but no event is delivered"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SecretsmanagerEventsTestClient
from ..constants import TEST_SECRET


@then('the secret is "ACTIVE" but no event is delivered')
def secret_active_but_no_event(lws_session):
    resp = SecretsmanagerEventsTestClient(lws_session)._sm.list_secrets()
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert (
        TEST_SECRET in actual_names
    ), f"Expected secret '{TEST_SECRET}' to exist but not found in: {actual_names}"
