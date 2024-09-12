import { DynamoProvider, generateResourceId } from "@alexslater-io/common";
import { PutCommand, QueryCommand } from "@aws-sdk/lib-dynamodb";
import { Customer } from "../types/Customer";

export type CustomerOptions = {
	firstName: string;
	lastName: string;
};
export class CustomerService {
	private readonly customerTableName = process.env.CUSTOMER_TABLE_NAME;

	constructor(private dbClient = DynamoProvider.instance) {}

	public create({
		firstName: minPlayers,
		lastName: maxPlayers,
	}: CustomerOptions): Customer {
		return {
			id: generateResourceId("customer", "customer"),
			firstName: minPlayers,
			lastName: maxPlayers,
		};
	}

	public async store(customer: Customer) {
		const request = new PutCommand({
			TableName: this.customerTableName,
			Item: customer,
		});
		await this.dbClient.send(request);
	}

	public async list(): Promise<Customer[]> {
		const request = new QueryCommand({
			TableName: this.customerTableName,
		});
		const result = await this.dbClient.send(request);
		if (!result.Items) {
			return [];
		}
		return result.Items as unknown as Promise<Customer[]>;
	}
}
