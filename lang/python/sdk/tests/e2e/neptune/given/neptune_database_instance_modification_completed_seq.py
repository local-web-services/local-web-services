"""Given: a "neptune" "instance" modification completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_INSTANCE


@given('a "neptune" "instance" modification completes')
def neptune_database_instance_modification_completed_seq(lws_session):
    lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "available")
