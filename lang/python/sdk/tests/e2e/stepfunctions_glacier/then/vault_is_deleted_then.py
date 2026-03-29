"""Then: the vault is "DELETED" and "SDK" task calls targeting it will fail"""

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsGlacierTestClient
from ..constants import TEST_VAULT


@then('the vault is "DELETED" and "SDK" task calls targeting it will fail')
def vault_is_deleted_then(lws_session):
    expected_exists = False
    actual_exists = StepfunctionsGlacierTestClient(lws_session).vault_exists()
    assert (
        actual_exists is expected_exists
    ), f"Expected vault '{TEST_VAULT}' to be deleted but it still exists"
