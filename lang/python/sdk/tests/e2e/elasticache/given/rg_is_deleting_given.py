"""Given: the replication group is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the replication group is "DELETING"')
def rg_is_deleting_given():
    pytest.skip("Cannot observe DELETING replication group state in lws")
