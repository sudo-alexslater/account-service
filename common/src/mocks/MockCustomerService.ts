import { generateResourceId, MockOf } from "@alexslater-io/common";
import { CustomerService } from "../services/CustomerService";
import { Customer } from "../types/Customer";

export class MockCustomerService implements MockOf<CustomerService> {
	constructor() {
		this.reset();
	}

	public get mock() {
		return this as unknown as CustomerService;
	}

	public mockedCreateResult: Customer;
	public numOfCreateCalls: number;
	public mockedListResult: Customer[];
	public reset(): void {
		console.log("Resetting Mock Customer Service");
		this.mockedCreateResult = {
			id: generateResourceId("customer", "customer"),
			firstName: "John",
			lastName: "Smith",
		};
		this.mockedListResult = [];
		this.numOfCreateCalls = 0;
	}

	public create(): Customer {
		this.numOfCreateCalls++;
		return this.mockedCreateResult;
	}
	public async store(customer: Customer) {
		console.log("Storing customer: ", customer);
		return;
	}
	public async list(): Promise<Customer[]> {
		console.log("Listing customers");
		return this.mockedListResult;
	}
}
