import { APIGatewayEvent } from "aws-lambda";

export const handler = (event: APIGatewayEvent) => {
	console.log(event);

	return {
		statusCode: 200,
		body: JSON.stringify({
			message: "list-customer",
		}),
	};
};
