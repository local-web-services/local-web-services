"""Given: the new "opensearch" "cluster" has not been prepared yet"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the new "opensearch" "cluster" has not been prepared yet')
def new_cluster_not_prepared_yet(world):
    pytest.skip(
        "Blue-green cluster preparation state not available in stateless integration tests."
    )
