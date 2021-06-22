defmodule Wabanex.User do
  # injeta código no módulo
  use Ecto.Schema

  # importação funções do changeset
  import Ecto.Changeset

  # tupla
  @primary_key {:id, :binary_id, autogenerate: true}
  # lista
  @fields [:email, :name, :password]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end
