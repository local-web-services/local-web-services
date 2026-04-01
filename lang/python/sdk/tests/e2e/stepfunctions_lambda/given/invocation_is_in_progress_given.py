"""Given: a "lambda" "invocation" was "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "invocation" was "IN_PROGRESS"')
def invocation_is_in_progress_given():
    pytest.skip("Cannot put a Lambda invocation into IN_PROGRESS state in lws")
