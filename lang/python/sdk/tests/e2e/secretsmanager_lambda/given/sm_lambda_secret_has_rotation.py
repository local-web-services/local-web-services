"""Given: the secret has a rotation function configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the secret has a rotation function configured")
def sm_lambda_secret_has_rotation():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")
