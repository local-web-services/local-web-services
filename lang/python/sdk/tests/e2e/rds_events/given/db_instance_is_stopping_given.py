"""Given: the "DB" instance was "STOPPING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance was "STOPPING"')
def db_instance_is_stopping_given():
    pytest.skip("Cannot trigger internal DB instance stopping state in lws")
