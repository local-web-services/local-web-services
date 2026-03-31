"""Given: a "neptune" "cluster" restore from neptune snapshot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" restore from neptune snapshot completes')
def neptune_cluster_restore_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster restore completion in lws")
