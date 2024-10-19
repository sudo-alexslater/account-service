import { generateResourceId, MockOf } from "@alexslater-io/common";
import { AccountService } from "../services/AccountService";
import { Account } from "../types/Account";

export class MockAccountService implements MockOf<AccountService> {
	constructor() {
		this.reset();
	}

	public get mock() {
		return this as unknown as AccountService;
	}

	public mockedCreateResult: Account;
	public numOfCreateCalls: number;
	public mockedListResult: Account[];
	public reset(): void {
		console.log("Resetting Mock Account Service");
		this.mockedCreateResult = {
			id: generateResourceId("account", "account"),
			firstName: "John",
			lastName: "Smith",
		};
		this.mockedListResult = [];
		this.numOfCreateCalls = 0;
	}

	public create(): Account {
		this.numOfCreateCalls++;
		return this.mockedCreateResult;
	}
	public async store(account: Account) {
		console.log("Storing account: ", account);
		return;
	}
	public async list(): Promise<Account[]> {
		console.log("Listing accounts");
		return this.mockedListResult;
	}
}
