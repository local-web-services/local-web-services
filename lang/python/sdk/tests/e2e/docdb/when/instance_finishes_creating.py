"""When: a "documentdb" "instance" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "instance" finishes creating')
def instance_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB instance creation completion in lws")
