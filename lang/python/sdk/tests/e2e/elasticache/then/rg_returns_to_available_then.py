"""Then: the "elasticache" "replication group" returns to "AVAILABLE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticache" "replication group" returns to "AVAILABLE" state')
def rg_returns_to_available_then():
    pytest.skip("Cannot observe internal replication group state transition in lws")
