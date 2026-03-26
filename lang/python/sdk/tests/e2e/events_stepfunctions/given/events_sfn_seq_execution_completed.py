"""Given: a running execution has completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has completed successfully")
def events_sfn_seq_execution_completed():
    pytest.skip("Cannot trigger internal Step Functions execution completion in lws")
