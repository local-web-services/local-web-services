"""Given: a running execution has published a message to the "SNS" topic and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has published a message to the "SNS" topic and succeeded')
def running_execution_published_to_topic_given():
    pytest.skip("Cannot pre-set a completed execution SNS task state for sequence setup")
