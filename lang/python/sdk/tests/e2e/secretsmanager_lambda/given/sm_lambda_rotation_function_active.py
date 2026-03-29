"""Given: the rotation function is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the rotation function is "ACTIVE"')
def sm_lambda_rotation_function_active():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")
