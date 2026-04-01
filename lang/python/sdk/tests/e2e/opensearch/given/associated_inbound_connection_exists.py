"""Given: the associated "opensearch" "inbound connection" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the associated "opensearch" "inbound connection" existed')
def associated_inbound_connection_exists():
    pytest.skip("Cannot create an associated inbound connection as a precondition in this context")
