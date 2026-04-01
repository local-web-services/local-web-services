"""Given: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds'
)
def running_execution_published_to_topic_given():
    pytest.skip("Cannot pre-set a completed execution SNS task state for sequence setup")
