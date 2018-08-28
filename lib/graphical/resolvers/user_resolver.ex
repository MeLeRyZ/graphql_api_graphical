defmodule Graphical.UserResolver do
    alias Graphical.Accounts

    def all(_args, _info) do
        {:ok, Accounts.list_users()}
    end

    def find(%{id: id}, _info) do
        case Accounts.get_user!(id) do
            nil -> {:error, "User id #{id} not found"}
            user -> {:ok, user}
        end
    end

    # needs a change for new 'update_changeset' func in accounts.ex
    def update(%{id: id, user: user_params}, _info) do
        Accounts.get_user!(id)
        |> Accounts.update_user(user_params)
    end

end
