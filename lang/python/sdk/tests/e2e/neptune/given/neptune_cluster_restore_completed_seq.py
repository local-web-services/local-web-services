"""Given: a database cluster restore from snapshot has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster restore from snapshot has completed")
def neptune_cluster_restore_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster restore completion in lws")
