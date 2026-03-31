"""When: an "opensearch" "index" is created in the "opensearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "opensearch" "index" is created in the "opensearch" "domain"')
def create_opensearch_index(world):
    pytest.skip("Cannot create OpenSearch index in lws")
