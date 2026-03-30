"""Given: the snapshot is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the snapshot is "CREATING"')
def snapshot_is_creating_given():
    pytest.skip("Cannot observe CREATING snapshot state in lws")
