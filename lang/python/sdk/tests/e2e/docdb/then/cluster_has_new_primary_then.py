"""Then: the cluster has a new primary instance"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the cluster has a new primary instance")
def cluster_has_new_primary_then():
    pytest.skip("Cannot observe internal cluster primary instance change in lws")
