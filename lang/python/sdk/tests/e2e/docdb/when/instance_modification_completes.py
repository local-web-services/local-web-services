"""When: a "documentdb" "instance" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "instance" modification completes')
def instance_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB instance modification completion in lws")
