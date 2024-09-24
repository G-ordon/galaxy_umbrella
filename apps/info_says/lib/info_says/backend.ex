defmodule InfoSays.Backend do

  @callback name() :: String.t()
  @callback compute(query :: String.t(), opts :: Keyword.t()) :: [%InfoSays.Result{}]

end
