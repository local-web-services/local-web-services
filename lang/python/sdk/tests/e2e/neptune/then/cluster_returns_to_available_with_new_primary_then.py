"""Then: the "neptune" "cluster" returns to "AVAILABLE" with a new primary neptune instance"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "neptune" "cluster" returns to "AVAILABLE" with a new primary neptune instance')
def cluster_returns_to_available_with_new_primary_then():
    pytest.skip("Cannot observe internal cluster primary promotion in lws")
