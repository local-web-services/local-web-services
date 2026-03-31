"""Given: the "documentdb" "instance" does not belong to this documentdb cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" does not belong to this documentdb cluster')
def instance_does_not_belong_to_cluster(world):
    pytest.skip("Cannot associate instance with a different cluster in integration tests.")
