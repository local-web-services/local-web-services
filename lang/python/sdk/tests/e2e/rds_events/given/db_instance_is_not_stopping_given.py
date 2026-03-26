"""Given: the "DB" instance is not "STOPPING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance is not "STOPPING"')
def db_instance_is_not_stopping_given():
    pytest.skip("Cannot control DB instance stopping state in lws")
