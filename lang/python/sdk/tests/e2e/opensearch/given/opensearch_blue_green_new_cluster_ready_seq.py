"""Given: the new cluster for a blue-green deployment has become ready"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the new cluster for a blue-green deployment has become ready")
def opensearch_blue_green_new_cluster_ready_seq():
    pytest.skip("Cannot trigger internal blue-green new cluster readiness in lws")
