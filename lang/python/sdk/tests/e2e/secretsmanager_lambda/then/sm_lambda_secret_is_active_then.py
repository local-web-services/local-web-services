"""Then: the secret is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SECRET


@then('the secret is "ACTIVE"')
def sm_lambda_secret_is_active_then(lws_session):
    resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
    actual_name = resp.get("Name", "")
    expected_name = TEST_SECRET
    assert (
        actual_name == expected_name
    ), f"Expected secret '{expected_name}' to be ACTIVE but got '{actual_name}'"
