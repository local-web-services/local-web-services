"""Given: the upload is InProgress"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the upload is InProgress")
def upload_is_in_progress_given():
    pytest.skip("Cannot observe InProgress upload state in this context")
