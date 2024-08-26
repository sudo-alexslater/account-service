import { Lobby, LobbyService } from "@alexslater-io/customer-service-common";
import { IFeature } from "@alexslater-io/common";

export type ListLobbiesOptions = {};
export class ListLobbies
	implements IFeature<ListLobbiesOptions, Promise<Lobby[]>>
{
	constructor(private lobbyService = new LobbyService()) {}

	public async run(options: ListLobbiesOptions) {
		return this.lobbyService.list();
	}
}
