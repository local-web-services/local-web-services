import type { KeyLike } from "./auth.js";

export interface UserPoolConfig {
  poolName: string;
  autoConfirmUsers?: boolean;
}

export interface StoredClient {
  clientId: string;
  clientName: string;
  poolId: string;
}

export interface StoredUser {
  username: string;
  sub: string;
  email: string | undefined;
  password: string;
  status: "CONFIRMED" | "UNCONFIRMED" | "FORCE_CHANGE_PASSWORD";
  enabled: boolean;
  attributes: { Name: string; Value: string }[];
  createdAt: number;
  pendingPasswordResetCode?: string;
}

export interface StoredGroup {
  GroupName: string;
  UserPoolId: string;
  Description?: string;
  CreatedAt: number;
  LastModifiedDate: number;
}

export interface StoredPool {
  id: string;
  name: string;
  arn: string;
  privateKey: KeyLike;
  publicKey: KeyLike;
  clients: Map<string, StoredClient>;
  users: Map<string, StoredUser>;
  groups: Map<string, StoredGroup>;
  groupMembers: Map<string, Set<string>>;
  createdAt: number;
}

export const REGION = "us-east-1";
export const ACCOUNT = "123456789012";

export function randomAlphanumeric(len: number): string {
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let result = "";
  for (let i = 0; i < len; i++) {
    result += chars[Math.floor(Math.random() * chars.length)];
  }
  return result;
}

export function makePoolId(): string {
  return `${REGION}_${randomAlphanumeric(9)}`;
}

export function makeClientId(): string {
  return randomAlphanumeric(26);
}
