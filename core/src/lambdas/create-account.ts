import { CreateAccountRequest } from "@alexslater-io/account-service-api";
import { APIGatewayEvent } from "aws-lambda";
import { CreateAccount } from "../features/CreateAccount";

export const handler = (event: APIGatewayEvent) => {
	console.log(event);
	const body = JSON.parse(event.body || "{}") as CreateAccountRequest;
	const fn = new CreateAccount();
	if (!body.firstName || !body.lastName) {
		return {
			statusCode: 400,
			body: JSON.stringify({
				message: "Missing required parameters",
			}),
		};
	}
	fn.run({ firstName: body.firstName, lastName: body.lastName });
	return {
		statusCode: 200,
		body: JSON.stringify({
			message: "create-account",
		}),
	};
};
