"""Given: the instance is "REBOOTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is "REBOOTING"')
def instance_is_rebooting_given():
    pytest.skip("Cannot observe REBOOTING instance state in lws")
