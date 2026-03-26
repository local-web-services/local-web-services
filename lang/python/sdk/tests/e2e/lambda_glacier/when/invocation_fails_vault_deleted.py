"""When: the Lambda function fails to upload because the vault has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to upload because the vault has been deleted")
def invocation_fails_vault_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
