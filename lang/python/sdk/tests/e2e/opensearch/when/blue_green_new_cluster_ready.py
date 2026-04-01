"""When: the new "opensearch" "cluster" for a blue-green deployment becomes ready"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the new "opensearch" "cluster" for a blue-green deployment becomes ready')
def blue_green_new_cluster_ready(lws_session, world):
    pytest.skip("Cannot trigger internal blue-green new cluster readiness in lws")
