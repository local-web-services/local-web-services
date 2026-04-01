"""Then: the "elasticache" "cluster" will be "AVAILABLE" again"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticache" "cluster" will be "AVAILABLE" again')
def cluster_is_available_again_then():
    pytest.skip("Cannot observe internal cluster state transition to AVAILABLE in lws")
