defmodule TorrentVideo.Repo do
  use Ecto.Repo,
    otp_app: :torrent_video,
    adapter: Ecto.Adapters.Postgres
end
