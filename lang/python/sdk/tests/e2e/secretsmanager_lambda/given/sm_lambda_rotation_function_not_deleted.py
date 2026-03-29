"""Given: the rotation function is not "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the rotation function is not "DELETED"')
def sm_lambda_rotation_function_not_deleted():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")
