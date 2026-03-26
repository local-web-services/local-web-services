"""Given: the secret already has a rotation function configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the secret already has a rotation function configured")
def sm_lambda_secret_already_has_rotation():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")
