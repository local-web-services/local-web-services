"""Then: the secret metadata is updated"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SecretsmanagerTestClient
from ..constants import TEST_DESCRIPTION, TEST_SECRET


@then("the secret metadata is updated")
def secret_metadata_updated(lws_session):
    resp = SecretsmanagerTestClient(lws_session).describe_secret(SecretId=TEST_SECRET)
    expected_description = TEST_DESCRIPTION
    actual_description = resp.get("Description", "")
    assert (
        actual_description == expected_description
    ), f"Expected description '{expected_description}' but got '{actual_description}'"
