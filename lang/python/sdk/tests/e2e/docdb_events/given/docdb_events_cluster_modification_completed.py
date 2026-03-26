"""Given: the cluster modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the cluster modification has completed")
def docdb_events_cluster_modification_completed():
    pytest.skip("Cannot trigger internal DocumentDB cluster modification completion in lws")
