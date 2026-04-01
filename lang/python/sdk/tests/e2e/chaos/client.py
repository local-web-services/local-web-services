"""Test client for chaos tests."""

from __future__ import annotations

import json
import urllib.request


class ChaosTestClient:
    def __init__(self, lws_session):
        self._session = lws_session

    def mgmt_port(self):
        return self._session._mgmt_port

    def get_chaos_status(self):
        port = self.mgmt_port()
        with urllib.request.urlopen(f"http://127.0.0.1:{port}/_ldk/chaos", timeout=5) as resp:
            return json.loads(resp.read())
