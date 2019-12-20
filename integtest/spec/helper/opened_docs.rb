# frozen_string_literal: true

require 'open3'

require_relative 'serving_docs'

class OpenedDocs < ServingDocs
  ##
  # Reads the logs of the preview without updating them from the subprocess.
  attr_reader :logs

  def initialize(cmd, uses_preview)
    super cmd

    wait_for_logs(/start worker processes$/, 60)
    return unless uses_preview

    wait_for_logs(/^preview server is listening on 3000$/, 60)
    wait_for_logs(/  Built in /, 60) # Wait for parcel as well
  end
end
