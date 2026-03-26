"""Given: rotation has been configured on the secret linking it to the Lambda rotation function"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("rotation has been configured on the secret linking it to the Lambda rotation function")
def sm_lambda_rotation_has_been_configured():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")
