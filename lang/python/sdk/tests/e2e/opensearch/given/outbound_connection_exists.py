"""Given: the "opensearch" "outbound connection" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "outbound connection" existed')
def outbound_connection_exists():
    pytest.skip("Cannot create an outbound connection as a precondition in this context")
