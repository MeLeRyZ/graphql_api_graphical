defmodule Graphical.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Graphical.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true # not be saved to DB
    field :password_hash, :string # after guardian
    has_many :posts, Graphical.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do # user -> %User{} = user
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  # new changesets for different reasons and Guardian token-app
  def update_changeset(%User{} = user, params \\ %{}) do
      user
      |> cast(params, [:name, :email], [:password])
      |> validate_required([:name, :email])
      |> put_pass_hash()
  end

  def registration_changeset(%User{} = user, params \\ %{}) do
      user
      |>cast(params, [:name, :email,:password])
      |>validate_required([[:name, :email,:password]])
      |>put_pass_hash()
  end

  # helper funcs
  def put_pass_hash(changeset) do
      case changeset do
          %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
              put_change(changeset, :password_hash, Comeinon.Bcrypt.hashpwsalt(password))
          _ ->
              changeset
      end
  end

end
