"""When: a "neptune" "cluster" restore from neptune snapshot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "neptune" "cluster" restore from neptune snapshot completes')
def cluster_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster restore completion in lws")
