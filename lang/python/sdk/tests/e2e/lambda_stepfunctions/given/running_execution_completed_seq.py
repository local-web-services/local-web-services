"""Given: a running execution has completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has completed successfully")
def running_execution_completed_seq():
    pytest.skip("Cannot observe internal Step Functions execution completion in lws")
