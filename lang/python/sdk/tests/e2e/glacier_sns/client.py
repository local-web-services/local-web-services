"""Test client for glacier_sns tests."""

from __future__ import annotations

from .constants import TEST_TOPIC_NAME, TEST_VAULT


class GlacierSnsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _glacier = lws_session.client("glacier")
        self._glacier = _glacier
        _sns = lws_session.client("sns")
        self._sns = _sns

    def create_vault(self, name=TEST_VAULT):
        try:
            self._glacier.create_vault(accountId="-", vaultName=name)
        except Exception:
            pass

    def create_topic(self, name=TEST_TOPIC_NAME):
        try:
            self._sns.create_topic(Name=name)
        except Exception:
            pass
