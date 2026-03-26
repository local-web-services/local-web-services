"""When: an index is created in the OpenSearch domain"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an index is created in the OpenSearch domain")
def create_opensearch_index(world):
    pytest.skip("Cannot create OpenSearch index in lws")
