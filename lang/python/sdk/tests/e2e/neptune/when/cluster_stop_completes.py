"""When: a stopped neptune database neptune cluster is started"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "neptune" "cluster" stop completes')
def cluster_stop_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")
