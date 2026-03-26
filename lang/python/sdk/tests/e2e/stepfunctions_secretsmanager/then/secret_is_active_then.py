"""Then: the secret is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsSecretsmanagerTestClient
from ..constants import TEST_SECRET


@then('the secret is "ACTIVE"')
def secret_is_active_then(lws_session):
    resp = StepfunctionsSecretsmanagerTestClient(lws_session)._sm_client.list_secrets()
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert (
        TEST_SECRET in actual_names
    ), f"Expected secret '{TEST_SECRET}' to exist but not found in: {actual_names}"
