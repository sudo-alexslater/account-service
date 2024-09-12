import { IFeature } from "@alexslater-io/common";
import {
	Customer,
	CustomerService,
} from "@alexslater-io/customer-service-common";

export type CreateCustomerOptions = {
	firstName: string;
	lastName: string;
};
export class CreateCustomer
	implements IFeature<CreateCustomerOptions, Promise<Customer | undefined>>
{
	constructor(private customerService = new CustomerService()) {}

	public async run({ firstName, lastName }: CreateCustomerOptions) {
		const customer = this.customerService.create({ firstName, lastName });
		try {
			await this.customerService.store(customer);
		} catch (error) {
			console.error("Error storing customer", error);
			return;
		}
		return customer;
	}
}
