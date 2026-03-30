"""Given: the instance is the primary of the cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the instance is the primary of the cluster")
def instance_is_primary_of_cluster():
    pytest.skip("Cannot control primary instance assignment in lws")
