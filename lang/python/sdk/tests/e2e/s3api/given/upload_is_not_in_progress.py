"""Given: the upload is not "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the upload is not "IN_PROGRESS"')
def upload_is_not_in_progress():
    pytest.skip("Cannot set upload to non-IN_PROGRESS state")
