"""Given: an async invocation has failed and been retried"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an async invocation has failed and been retried")
def lambda_seq_async_retried():
    pytest.skip("Cannot trigger Lambda async retry in lws")
