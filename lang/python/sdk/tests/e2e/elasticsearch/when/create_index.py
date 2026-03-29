"""When: an index is created in an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an index is created in an active domain")
def create_index(lws_session, world):
    pytest.skip("Cannot create an index without connecting to the Elasticsearch endpoint in lws")
