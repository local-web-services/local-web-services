"""When: an "opensearch" "inbound connection" is accepted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "opensearch" "inbound connection" is accepted')
def accept_inbound_connection(lws_session, world):
    pytest.skip("Cannot accept inbound cross-cluster connection in lws")
