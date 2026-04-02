"""Then: the "opensearch" "connection" will be in "PENDING_ACCEPTANCE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "opensearch" "connection" will be in "PENDING_ACCEPTANCE" state')
def connection_is_pending_then():
    pytest.skip("Cannot observe internal connection PENDING_ACCEPTANCE state in lws")
