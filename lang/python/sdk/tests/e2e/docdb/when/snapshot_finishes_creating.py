"""When: a "documentdb" "cluster" documentdb snapshot finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "cluster" documentdb snapshot finishes creating')
def snapshot_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB snapshot creation completion in lws")
