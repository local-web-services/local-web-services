"""When: a database cluster restore from snapshot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database cluster restore from snapshot completes")
def cluster_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster restore completion in lws")
