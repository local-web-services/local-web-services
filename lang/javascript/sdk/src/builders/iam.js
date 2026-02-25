"use strict";

class IamBuilder {
  constructor(mgmtPort) {
    this.mgmtPort = mgmtPort;
    this.updates = {};
    this.identities = {};
  }

  mode(mode) {
    this.updates.mode = mode;
    return this;
  }

  defaultIdentity(name) {
    this.updates.default_identity = name;
    return this;
  }

  identity(name) {
    return new IdentityBuilder(this, name);
  }

  _registerIdentity(name, config) {
    this.identities[name] = config;
  }

  async apply() {
    const payload = { ...this.updates };
    if (Object.keys(this.identities).length > 0) {
      payload.identities = this.identities;
    }
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/iam-auth`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });
    this.updates = {};
    this.identities = {};
  }
}

class IdentityBuilder {
  constructor(parent, name) {
    this.parent = parent;
    this.name = name;
    this.inlinePolicies = [];
    this.boundary = undefined;
  }

  allow(actions, resource = "*") {
    this.inlinePolicies.push({
      Statement: [{ Effect: "Allow", Action: actions, Resource: resource }],
    });
    return this;
  }

  deny(actions, resource = "*") {
    this.inlinePolicies.push({
      Statement: [{ Effect: "Deny", Action: actions, Resource: resource }],
    });
    return this;
  }

  apply() {
    const config = { inline_policies: this.inlinePolicies };
    if (this.boundary) config.boundary_policy = this.boundary;
    this.parent._registerIdentity(this.name, config);
    return this.parent;
  }
}

module.exports = { IamBuilder, IdentityBuilder };
