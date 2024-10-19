import { describe, expect, test } from "@jest/globals";
const sum = (num1: number, num2: number) => num1 + num2;

describe("Account Service", () => {
	test.skip("should create a account", () => {
		expect(sum(1, 2)).toBe(3);
	});
});
