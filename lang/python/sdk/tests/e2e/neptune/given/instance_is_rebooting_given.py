"""Given: the "neptune" "instance" was "REBOOTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "instance" was "REBOOTING"')
def instance_is_rebooting_given():
    pytest.skip("Cannot observe REBOOTING instance state in lws")
