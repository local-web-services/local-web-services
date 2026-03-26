"""Then: the cluster enters "MODIFYING" state for primary promotion"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster enters "MODIFYING" state for primary promotion')
def cluster_enters_modifying_for_primary_promotion_then():
    pytest.skip("Cannot observe internal cluster modification for primary promotion in lws")
