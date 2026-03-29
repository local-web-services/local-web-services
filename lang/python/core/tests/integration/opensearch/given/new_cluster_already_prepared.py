"""Given: the new cluster has already been prepared"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the new cluster has already been prepared")
def new_cluster_already_prepared(world):
    pytest.skip(
        "Blue-green cluster preparation state not available in stateless integration tests."
    )
