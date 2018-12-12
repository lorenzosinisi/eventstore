defmodule Mix.Tasks.EventStore.Drop do
  @moduledoc """
  Drop the database for the EventStore.

  ## Examples

      mix event_store.drop

  """

  use Mix.Task

  alias EventStore.Config

  @shortdoc "Drop the database for the EventStore"

  @doc false
  def run(args) do
    config = Config.parsed()
    {opts, _, _} = OptionParser.parse(args, switches: [quiet: :boolean])
    opts = Keyword.merge([is_mix: false, quiet: false], opts)

    if skip_safety_warnings?() or
         Mix.shell().yes?("Are you sure you want to drop the EventStore database?") do
      EventStore.Tasks.Drop.exec(config, opts)
    end
  end

  defp skip_safety_warnings? do
    Mix.Project.config()[:start_permanent] != true
  end
end
