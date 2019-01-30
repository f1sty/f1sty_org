defmodule Site.User do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> encrypt_password()
    |> validate_required([:username, :password])
  end

  def get(username) do
    Site.Repo.get_by(__MODULE__, username: username)
  end

  defp encrypt_password(changeset) do
    with pwd <- changeset
         |> get_change(:password)
         |> Comeonin.Bcrypt.hashpwsalt() do
      put_change(changeset, :password, pwd)
    end
  end
end
