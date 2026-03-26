"""Then: the secret is "PENDING_DELETION" and will cause task failures when read"""

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsSecretsmanagerTestClient
from ..constants import TEST_SECRET


@then('the secret is "PENDING_DELETION" and will cause task failures when read')
def secret_is_pending_deletion_then(lws_session):
    resp = StepfunctionsSecretsmanagerTestClient(lws_session)._sm_client.list_secrets(
        IncludePlannedDeletion=True
    )
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert (
        TEST_SECRET in actual_names
    ), f"Expected secret '{TEST_SECRET}' to appear (PENDING_DELETION) but not found in: {actual_names}"  # noqa: E501
