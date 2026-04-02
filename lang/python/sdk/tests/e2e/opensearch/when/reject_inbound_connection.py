"""When: an "opensearch" "inbound connection" is rejected"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "opensearch" "inbound connection" is rejected')
def reject_inbound_connection(lws_session, world):
    pytest.skip("Cannot reject inbound cross-cluster connection in lws")
