"""When: a database cluster stop completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database cluster stop completes")
def cluster_stop_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")
