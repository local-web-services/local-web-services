"""Given: the user is "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is "MODIFYING"')
def user_is_modifying_given():
    pytest.skip("Cannot trigger internal user MODIFYING state in lws")
