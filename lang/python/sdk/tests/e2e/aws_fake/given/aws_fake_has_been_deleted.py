"""Given: an "AWS" fake has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('an "AWS" fake has been deleted')
def aws_fake_has_been_deleted(lws_session):
    AwsFakeTestClient(lws_session).create()
    AwsFakeTestClient(lws_session).delete()
