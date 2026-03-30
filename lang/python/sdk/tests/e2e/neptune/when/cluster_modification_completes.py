"""When: a database cluster modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database cluster modification completes")
def cluster_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster modification completion in lws")
