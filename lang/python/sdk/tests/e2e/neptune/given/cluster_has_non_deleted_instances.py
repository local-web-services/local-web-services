"""Given: the "neptune" "cluster" has non-deleted instances"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given('the "neptune" "cluster" has non-deleted instances')
def cluster_has_non_deleted_instances(lws_session):
    NeptuneTestClient(lws_session).create_instance()
