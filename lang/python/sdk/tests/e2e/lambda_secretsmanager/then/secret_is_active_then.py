"""Then: the secret is "ACTIVE" and can be read by Lambda"""

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaSecretsmanagerTestClient
from ..constants import TEST_SECRET


@then('the secret is "ACTIVE" and can be read by Lambda')
def secret_is_active_then(lws_session):
    resp = LambdaSecretsmanagerTestClient(lws_session)._secretsmanager.describe_secret(
        SecretId=TEST_SECRET
    )
    actual_name = resp.get("Name", "")
    expected_name = TEST_SECRET
    assert (
        actual_name == expected_name
    ), f"Expected secret name '{expected_name}' but got '{actual_name}'"
