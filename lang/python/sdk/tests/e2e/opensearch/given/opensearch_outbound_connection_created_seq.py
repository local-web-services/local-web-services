"""Given: an outbound cross-cluster connection is created between two "opensearch" "domain"s"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an outbound cross-cluster connection is created between two "opensearch" "domain"s')
def opensearch_outbound_connection_created_seq():
    pytest.skip("Cannot create cross-cluster connection in lws")
