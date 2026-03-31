"""Then: the "opensearch" "inbound connection" will be in "DELETING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "opensearch" "inbound connection" will be in "DELETING" state')
def inbound_connection_deleting_then():
    pytest.skip("Cannot observe internal inbound connection DELETING state in lws")
