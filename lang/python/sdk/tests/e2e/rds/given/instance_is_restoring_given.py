"""Given: the "rds" "instance" was "RESTORING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "rds" "instance" was "RESTORING"')
def instance_is_restoring_given():
    pytest.skip("Cannot observe RESTORING instance state in lws")
