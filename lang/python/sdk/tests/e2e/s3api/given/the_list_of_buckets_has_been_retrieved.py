"""Given: the list of buckets has been retrieved"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given("the list of buckets has been retrieved")
def the_list_of_buckets_has_been_retrieved(lws_session):
    S3apiTestClient(lws_session).list_buckets()
