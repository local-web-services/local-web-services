"""Given: an "opensearch" "inbound connection" is accepted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "opensearch" "inbound connection" is accepted')
def opensearch_inbound_connection_accepted_seq():
    pytest.skip("Cannot accept inbound cross-cluster connection in lws")
