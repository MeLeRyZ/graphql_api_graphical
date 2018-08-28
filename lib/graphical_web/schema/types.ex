defmodule GraphicalWeb.Schema.Types do
    @moduledoc """
    Needs own view in views. Named like top-level of this module.
    """
    use Absinthe.Schema.Notation # look in docs
    use Absinthe.Ecto, repo: Graphical.Repo # reference to DB

    # mirroring db
    object :user do
        field :id, :id
        field :name, :string
        field :email, :string
        field :posts, list_of(:post), resolve: assoc(:posts)
            #  name,  type+f,         association
    end

    object :post do
        field :id, :id
        field :title, :string
        field :body, :string  # but 'text' in phx.gen.json
        field :user, :user, resolve: assoc(:user)
            #  name, type+f, association
    end
end
