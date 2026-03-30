"""When: a database cluster creation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database cluster creation fails")
def cluster_creation_fails(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster creation failure in lws")
