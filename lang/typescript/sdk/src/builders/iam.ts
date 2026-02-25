/** Fluent builder for configuring IAM authorization at runtime. */

export class IamBuilder {
  private updates: Record<string, unknown> = {};
  private identities: Record<string, unknown> = {};

  constructor(private readonly mgmtPort: number) {}

  mode(mode: "enforce" | "audit" | "disabled"): IamBuilder {
    this.updates.mode = mode;
    return this;
  }

  defaultIdentity(name: string): IamBuilder {
    this.updates.default_identity = name;
    return this;
  }

  identity(name: string): IdentityBuilder {
    return new IdentityBuilder(this, name);
  }

  _registerIdentity(name: string, config: Record<string, unknown>): void {
    this.identities[name] = config;
  }

  async apply(): Promise<void> {
    const payload: Record<string, unknown> = { ...this.updates };
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

export class IdentityBuilder {
  private inlinePolicies: Array<Record<string, unknown>> = [];
  private boundary: Record<string, unknown> | undefined;

  constructor(
    private readonly parent: IamBuilder,
    private readonly name: string
  ) {}

  allow(actions: string[], resource = "*"): IdentityBuilder {
    this.inlinePolicies.push({
      Statement: [{ Effect: "Allow", Action: actions, Resource: resource }],
    });
    return this;
  }

  deny(actions: string[], resource = "*"): IdentityBuilder {
    this.inlinePolicies.push({
      Statement: [{ Effect: "Deny", Action: actions, Resource: resource }],
    });
    return this;
  }

  apply(): IamBuilder {
    const config: Record<string, unknown> = {
      inline_policies: this.inlinePolicies,
    };
    if (this.boundary) config.boundary_policy = this.boundary;
    this.parent._registerIdentity(this.name, config);
    return this.parent;
  }
}
