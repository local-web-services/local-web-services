"""Given: the new "opensearch" "cluster" was ready"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the new "opensearch" "cluster" was ready')
def new_cluster_is_ready():
    pytest.skip("Cannot configure blue-green deployment cluster readiness in lws")
