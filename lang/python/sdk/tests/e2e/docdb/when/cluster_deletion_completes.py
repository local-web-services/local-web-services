"""When: a "documentdb" "cluster" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "cluster" deletion completes')
def cluster_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB cluster deletion completion in lws")
