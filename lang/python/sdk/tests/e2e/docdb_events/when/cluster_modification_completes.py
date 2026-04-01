"""When: the "documentdb" "cluster" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "documentdb" "cluster" modification completes')
def cluster_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB cluster modification completion in lws")
