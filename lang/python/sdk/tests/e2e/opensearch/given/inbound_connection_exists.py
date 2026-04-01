"""Given: the "opensearch" "inbound connection" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "inbound connection" existed')
def inbound_connection_exists():
    pytest.skip("Cannot create an inbound connection as a precondition in this context")
