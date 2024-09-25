# apps/rumbl/priv/repo/backend_seeds.exs

# You might need to alias or import your Rumbl.Accounts module
{:ok, _} = Galaxy.Accounts.create_user(%{
  name: "Wolfram",
  email: "wolfram@examle.com"
})

IO.puts("Wolfram user created!")
