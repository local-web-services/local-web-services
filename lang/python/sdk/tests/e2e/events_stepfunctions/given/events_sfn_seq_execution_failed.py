"""Given: a running execution has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has failed")
def events_sfn_seq_execution_failed():
    pytest.skip("Cannot trigger internal Step Functions execution failure in lws")
