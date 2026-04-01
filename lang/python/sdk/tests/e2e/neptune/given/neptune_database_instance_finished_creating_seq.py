"""Given: a "neptune" "instance" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_INSTANCE


@given('a "neptune" "instance" finishes creating')
def neptune_database_instance_finished_creating_seq(lws_session):
    lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "available")
