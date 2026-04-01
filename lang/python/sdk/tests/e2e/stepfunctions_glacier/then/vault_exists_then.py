"""Then: the "glacier" "vault" will exist"""

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsGlacierTestClient
from ..constants import TEST_VAULT


@then('the "glacier" "vault" will exist')
def vault_exists_then(lws_session):
    expected_vault_name = TEST_VAULT
    actual_exists = StepfunctionsGlacierTestClient(lws_session).vault_exists()
    assert (
        actual_exists is True
    ), f"Expected vault '{expected_vault_name}' to exist but it was not found"
