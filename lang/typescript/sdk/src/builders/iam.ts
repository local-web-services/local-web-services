export interface IamIdentityPolicy {
  inline_policies: Array<{ actions: string[]; effect: "Allow" | "Deny" }>;
  boundary_policy?: { actions: string[] };
}

export interface IamConfig {
  mode: "enforce" | "audit" | "disabled";
  default_identity: string;
  identities: Record<string, IamIdentityPolicy>;
}

export class IamIdentityBuilder {
  private readonly name: string;
  private readonly parent: IamBuilder;
  private allowActions: string[] = [];
  private denyActions: string[] = [];
  private boundaryActions: string[] = [];

  constructor(name: string, parent: IamBuilder) {
    this.name = name;
    this.parent = parent;
  }

  allow(actions: string[]): this {
    this.allowActions.push(...actions);
    return this;
  }

  deny(actions: string[]): this {
    this.denyActions.push(...actions);
    return this;
  }

  boundary(actions: string[]): this {
    this.boundaryActions.push(...actions);
    return this;
  }

  done(): IamBuilder {
    return this.parent;
  }

  buildPolicy(): IamIdentityPolicy {
    const policies: Array<{ actions: string[]; effect: "Allow" | "Deny" }> = [];
    if (this.allowActions.length > 0) {
      policies.push({ actions: [...this.allowActions], effect: "Allow" });
    }
    if (this.denyActions.length > 0) {
      policies.push({ actions: [...this.denyActions], effect: "Deny" });
    }
    const result: IamIdentityPolicy = { inline_policies: policies };
    if (this.boundaryActions.length > 0) {
      result.boundary_policy = { actions: [...this.boundaryActions] };
    }
    return result;
  }

  getName(): string {
    return this.name;
  }
}

export class IamBuilder {
  private readonly managementUrl: string;
  private iamMode: "enforce" | "audit" | "disabled" = "disabled";
  private iamDefaultIdentity: string = "admin";
  private identityBuilders: IamIdentityBuilder[] = [];
  private extraIdentities: Record<string, IamIdentityPolicy> = {};

  constructor(managementUrl: string) {
    this.managementUrl = managementUrl;
  }

  mode(m: "enforce" | "audit" | "disabled"): this {
    this.iamMode = m;
    return this;
  }

  defaultIdentity(name: string): this {
    this.iamDefaultIdentity = name;
    return this;
  }

  identity(name: string): IamIdentityBuilder {
    const builder = new IamIdentityBuilder(name, this);
    this.identityBuilders.push(builder);
    return builder;
  }

  build(): IamConfig {
    const identities: Record<string, IamIdentityPolicy> = { ...this.extraIdentities };
    for (const ib of this.identityBuilders) {
      identities[ib.getName()] = ib.buildPolicy();
    }
    return {
      mode: this.iamMode,
      default_identity: this.iamDefaultIdentity,
      identities,
    };
  }

  async apply(): Promise<void> {
    await fetch(`${this.managementUrl}/_ldk/iam-auth`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(this.build()),
    });
  }

  async reset(): Promise<void> {
    await fetch(`${this.managementUrl}/_ldk/iam-auth`, { method: "DELETE" });
  }
}
