import { DynamoProvider, generateResourceId } from "@alexslater-io/common";
import { PutCommand, QueryCommand } from "@aws-sdk/lib-dynamodb";
import { Account } from "../types/Account";

export type AccountOptions = {
	firstName: string;
	lastName: string;
};
export class AccountService {
	private readonly accountTableName = process.env.CUSTOMER_TABLE_NAME;

	constructor(private dbClient = DynamoProvider.instance) {}

	public create({
		firstName: minPlayers,
		lastName: maxPlayers,
	}: AccountOptions): Account {
		return {
			id: generateResourceId("account", "account"),
			firstName: minPlayers,
			lastName: maxPlayers,
		};
	}

	public async store(account: Account) {
		const request = new PutCommand({
			TableName: this.accountTableName,
			Item: account,
		});
		await this.dbClient.send(request);
	}

	public async list(): Promise<Account[]> {
		const request = new QueryCommand({
			TableName: this.accountTableName,
		});
		const result = await this.dbClient.send(request);
		if (!result.Items) {
			return [];
		}
		return result.Items as unknown as Promise<Account[]>;
	}
}
