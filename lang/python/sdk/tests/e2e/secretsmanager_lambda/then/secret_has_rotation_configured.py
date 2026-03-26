"""Then: the secret has a rotation function configured"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the secret has a rotation function configured")
def secret_has_rotation_configured():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")
