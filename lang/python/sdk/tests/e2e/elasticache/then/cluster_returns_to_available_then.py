"""Then: the "elasticache" "cluster" returns to "AVAILABLE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticache" "cluster" returns to "AVAILABLE" state')
def cluster_returns_to_available_then():
    pytest.skip("Cannot observe internal cluster state transition in lws")
