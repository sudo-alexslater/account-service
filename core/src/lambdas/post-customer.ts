import { CreateCustomerRequest } from "@alexslater-io/customer-service-api";
import { APIGatewayEvent } from "aws-lambda";
import { CreateCustomer } from "../features/CreateCustomer";

export const handler = (event: APIGatewayEvent) => {
	const body = JSON.parse(event.body || "{}") as CreateCustomerRequest;
	const fn = new CreateCustomer();
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
			message: "create-customer",
		}),
	};
};
