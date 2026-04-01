"""When: the "neptune" "cluster" finishes stopping"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "neptune" "cluster" finishes stopping')
def cluster_stop_complete(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")
