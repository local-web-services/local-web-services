"use strict";

class ChaosBuilder {
  constructor(service, mgmtPort) {
    this.service = service;
    this.mgmtPort = mgmtPort;
    this.config = { enabled: true };
  }

  errorRate(rate) {
    this.config.error_rate = rate;
    return this;
  }

  latency(minMs, maxMs) {
    this.config.latency_min_ms = minMs;
    this.config.latency_max_ms = maxMs;
    return this;
  }

  connectionResetRate(rate) {
    this.config.connection_reset_rate = rate;
    return this;
  }

  timeoutRate(rate) {
    this.config.timeout_rate = rate;
    return this;
  }

  async apply() {
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/chaos`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this.service]: this.config }),
    });
  }

  async clear() {
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/chaos`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        [this.service]: { enabled: false, error_rate: 0.0 },
      }),
    });
  }
}

module.exports = { ChaosBuilder };
