defmodule NorthwindMe.Validations do
  import Ecto.Changeset
  alias NorthwindMe.Repo

  def validate_foreign_key_id(changeset, target, field) when is_atom(field) do
    val = get_field(changeset, field)

    if is_nil(val) do
      add_error(changeset, field, "key '%{field}' not found in changeset",
        field: field,
        validations: :foreign_key_id
      )
    else
      result = Repo.get(target, val)

      case result do
        nil ->
          add_error(changeset, field, "no '%{record}' with primary key value '%{pkval}'",
            record: to_string(target),
            pkval: val,
            validations: :foreign_key_id
          )

        _ ->
          changeset
      end
    end
  end
end
