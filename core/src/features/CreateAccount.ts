import { Account, AccountService } from "@alexslater-io/account-service-common";
import { IFeature } from "@alexslater-io/common";

export type CreateAccountOptions = {
	firstName: string;
	lastName: string;
};
export class CreateAccount
	implements IFeature<CreateAccountOptions, Promise<Account | undefined>>
{
	constructor(private accountService = new AccountService()) {}

	public async run({ firstName, lastName }: CreateAccountOptions) {
		const account = this.accountService.create({ firstName, lastName });
		try {
			await this.accountService.store(account);
		} catch (error) {
			console.error("Error storing account", error);
			return;
		}
		return account;
	}
}
