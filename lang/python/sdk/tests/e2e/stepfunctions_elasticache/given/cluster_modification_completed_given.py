"""Given: the cluster modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the cluster modification has completed")
def cluster_modification_completed_given():
    pytest.skip("Cannot pre-set a completed cluster modification state for sequence setup")
