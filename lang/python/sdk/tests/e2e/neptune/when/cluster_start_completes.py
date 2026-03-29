"""When: a database cluster start completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database cluster start completes")
def cluster_start_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster start completion in lws")
