"""When: a running "step functions" "execution" fails because the Glacier vault has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running "step functions" "execution" fails because the Glacier vault has been deleted')
def execution_fails_vault_deleted(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to deleted Glacier vault in lws"
    )
