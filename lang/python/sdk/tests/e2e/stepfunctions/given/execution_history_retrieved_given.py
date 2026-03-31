"""Given: the event history of an execution is retrieved"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the event history of an execution is retrieved")
def execution_history_retrieved_given():
    pytest.skip("Cannot pre-set execution event history retrieval state for sequence setup")
