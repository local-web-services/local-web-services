/** LwsManagementSdk — class-based management SDK for use in tests and tooling. */

import type { IamPolicy } from "./types";
import {
  chaosEnable,
  chaosDisable,
  chaosSet,
  chaosStatus,
  iamSet,
  iamDisable,
  iamSetIdentity,
  iamRegisterIdentities,
  iamStatus,
  reset as cliReset,
} from "./cli";

export class LwsManagementSdk {
  readonly chaos: {
    enable(service: string): Promise<void>;
    disable(service: string): Promise<void>;
    set(service: string, options: { errorRate?: number; latencyMin?: number; latencyMax?: number }): Promise<void>;
    status(): Promise<unknown>;
  };

  readonly iam: {
    set(service: string, mode: string): Promise<void>;
    disable(service: string): Promise<void>;
    setIdentity(identity: string): Promise<void>;
    registerIdentities(
      identities: Record<string, { inline_policies?: IamPolicy[]; boundary_policy?: IamPolicy }>
    ): Promise<void>;
    status(): Promise<unknown>;
  };

  constructor(private readonly port: number) {
    this.chaos = {
      enable: (service) => chaosEnable(port, service),
      disable: (service) => chaosDisable(port, service),
      set: (service, options) => chaosSet(port, service, options),
      status: () => chaosStatus(port),
    };

    this.iam = {
      set: (service, mode) => iamSet(port, service, mode),
      disable: (service) => iamDisable(port, service),
      setIdentity: (identity) => iamSetIdentity(port, identity),
      registerIdentities: (identities) => iamRegisterIdentities(port, identities),
      status: () => iamStatus(port),
    };
  }

  async reset(): Promise<void> {
    await cliReset(this.port);
  }
}
