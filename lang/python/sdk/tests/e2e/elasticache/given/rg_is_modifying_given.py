"""Given: the replication group is "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the replication group is "MODIFYING"')
def rg_is_modifying_given():
    pytest.skip("Cannot trigger internal replication group MODIFYING state in lws")
